import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/screens/smeup_dynamic_screen.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class SmeupDynamismService {
  static Map variables = Map();
  static const loggerId = "SmeupDynamismService";
  static GlobalKey<ScaffoldState> currentScaffoldKey;

  static void dumpVariables() {
    variables.forEach((key, value) {
      SmeupLogService.writeDebugMessage(
          "$loggerId - Variables status: $key=\"$value\"",
          logType: LogType.info);
    });
  }

  static void storeDynamicVariables(Map data) {
    if (data != null) {
      data.entries.forEach((element) {
        if (element.value != null) {
          String key = element.key;
          if (key == 'tipo' || key == 't') key = 'T1';
          if (key == 'parametro' || key == 'p') key = 'P1';
          if (key == 'codice' || key == 'k') key = 'K1';
          if (key == 'testo') key = 'Tx';
          if (key == 'nome') key = 'Nm';

          String value = '';
          if (element.value is Map && element.value['smeupObject'] != null) {
            value = SmeupUtilities.extractValueFromName(element.value);
          } else {
            value = element.value.toString();
          }
          variables[key] = value;
          if (SmeupOptions.isVariablesChangingLogEnabled) {
            SmeupLogService.writeDebugMessage(
                "$loggerId - Settings variable $key=\"$value\" by data $data",
                logType: LogType.info);
          }
        }
      });
    }
  }

  static void storeFormVariables(Map data) {
    if (data != null && data['name'] != null) {
      variables[data['name']] = data['value'] ?? '';
      if (SmeupOptions.isVariablesChangingLogEnabled) {
        SmeupLogService.writeDebugMessage(
            "$loggerId - Settings variable ${data['name']}=\"${data['value']}\" by data $data",
            logType: LogType.info);
      }
    }
  }

  static Future<void> run(List dynamisms, BuildContext context, String event,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    if (dynamisms == null) return;

    List selectedDynamisms =
        dynamisms.where((element) => element['event'] == event).toList();
    if (selectedDynamisms == null) return;

    for (var i = 0; i < selectedDynamisms.length; i++) {
      final dynamism = selectedDynamisms[i];

      if (dynamism == null) return;

      if (dynamism['variables'] != null) {
        (dynamism['variables'] as List<dynamic>).forEach((element) {
          String value = '';
          if (element['value'].toString().startsWith('[')) {
            String varName = element['value']
                .toString()
                .trim()
                .replaceAll('[', '')
                .replaceAll(']', '');
            value = variables[varName].toString();
          } else {
            value = element['value'];
          }
          var newEl = {
            "name": element['name'],
            "type": element['type'],
            "value": value
          };
          SmeupDynamismService.storeFormVariables(newEl);
        });
      }

      if (dynamism['exec'] != null) {
        String exec = dynamism['exec'];

        if (exec.toLowerCase() == 'close') {
          Navigator.of(context).pop();
          return;
        }

        SmeupFun smeupFunExec = SmeupFun(exec);
        String notify = smeupFunExec.fun['fun']['NOTIFY'];

        switch (smeupFunExec.fun['fun']['component']) {
          case 'EXD':
            switch (smeupFunExec.fun['fun']['service'].toString()) {
              case '*ROUTE':
                // Pass SmeupFun reference to destination screen
                Navigator.pushNamed(
                    context, '/${smeupFunExec.fun['fun']['obj2']['k']}',
                    arguments: {'smeupFun': smeupFunExec});
                break;
              default:
                if (smeupFunExec.fun['fun']['G'] == 'DLG') {
                  _showDialog(smeupFunExec, context, notify, scaffoldKey);
                } else {
                  Navigator.of(context).pushNamed(SmeupDynamicScreen.routeName,
                      arguments: {'smeupFun': smeupFunExec}).then((value) {
                    _manageNotify(notify, context, scaffoldKey.hashCode);
                  });
                }
            }

            break;
          case 'WEB':
            switch (smeupFunExec.fun['fun']['service'].toString()) {
              case '*URL':
                String url = smeupFunExec.fun['fun']['INPUT'];
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  SmeupLogService.writeDebugMessage('Could not launch $url',
                      logType: LogType.error);
                }
            }
            break;

          case 'FBK':
            final smeupServiceResponse =
                await SmeupDataService.invoke(smeupFunExec);

            await manageResponseMessage(
                context, smeupServiceResponse.result, scaffoldKey);
            if (smeupServiceResponse.succeded) {
              _manageNotify(notify, context, scaffoldKey.hashCode);
            } else {
              return;
            }

            break;
          default:
        }
      }

      if (dynamism['targets'] != null &&
          dynamism['targets'] is List &&
          (dynamism['targets'] as List).length > 0) {
        List<String> targets =
            (dynamism['targets'] as List).map((e) => e.toString()).toList();
        SmeupWidgetNotifier.notifyWidgets(
            targets, context, scaffoldKey.hashCode);
      }
    }
  }

  static _showDialog(SmeupFun smeupFunExec, BuildContext context, String notify,
      GlobalKey<ScaffoldState> scaffoldKey) {
    showDialog(
        barrierDismissible: false,
        routeSettings: RouteSettings(
            arguments: {'smeupFun': smeupFunExec, 'isDialog': true}),
        context: context,
        builder: (_) => SimpleDialog(
              contentPadding: EdgeInsets.only(top: 20, bottom: 20),
              backgroundColor: SmeupOptions.theme.scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              children: [
                Container(height: 300, width: 350, child: SmeupDynamicScreen())
              ],
            )).then((value) {
      _manageNotify(notify, context, scaffoldKey.hashCode);
    });
  }

  static String replaceFunVariables(String fun) {
    SmeupDynamismService.variables.entries.forEach((element) {
      if (element.value is String) {
        fun =
            fun.replaceAll('[${element.key}]', element.value.toString() ?? '');
      } else {
        fun = fun.replaceAll(
            '\"[${element.key}]\"', element.value.toString() ?? '');
      }
    });
    try {
      // remove not replacable variable
      RegExp re = RegExp(r'\[[^\]]*\]');
      String newFun = fun;
      re.allMatches(fun).forEach((match) {
        final value = fun
            .substring(match.start, match.end)
            .replaceFirst('[', '')
            .replaceFirst(']', '');
        if (value != null && value.isNotEmpty) {
          newFun = newFun.replaceAll('[$value]', '');
          SmeupLogService.writeDebugMessage(
              'removed the parameter: $value in replaceFunVariables',
              logType: LogType.warning);
        }
      });
      fun = newFun;
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in replaceFunVariables: $fun ',
          logType: LogType.error);
    }
    return fun;
  }

  static _manageNotify(
      String notify, BuildContext context, int scaffoldHashCode) {
    if (notify != null && notify.isNotEmpty) {
      var widgetsIds = notify.toString().split('\\');
      if (widgetsIds.length > 0) {
        SmeupWidgetNotifier.notifyWidgets(
            widgetsIds, context, scaffoldHashCode);
      }
    }
  }

  static manageResponseMessage(BuildContext context, dynamic response,
      GlobalKey<ScaffoldState> scaffoldKey) async {
    try {
      if (response.data['messages'] != null) {
        List messages = response.data['messages'];
        if (messages.length > 0) {
          messages.forEach((message) {
            MessagesPromptMode mode =
                message['mode'] ?? MessagesPromptMode.snackbar;
            LogType severity = message['gravity'] ?? LogType.info;
            String text = message['message'];

            Color color;
            switch (severity) {
              case LogType.error:
                color = SmeupOptions.theme.errorColor;
                break;
              case LogType.warning:
                color = Colors.amberAccent;
                break;
              default:
              //color = Colors.green;
            }

            if (text.isNotEmpty) {
              switch (mode) {
                case MessagesPromptMode.snackbar:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(text),
                      backgroundColor: color,
                    ),
                  );

                  break;
                default:
              }
            }
          });
          await new Future.delayed(const Duration(seconds: 1));
        }
      }
    } catch (e) {}
  }
}
