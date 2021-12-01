import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_widget_notification_service.dart';
import 'package:mobile_components_library/smeup/screens/smeup_dynamic_screen.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:url_launcher/url_launcher.dart';

class SmeupDynamismService {
  static const loggerId = "SmeupDynamismService";
  //static GlobalKey<ScaffoldState> currentScaffoldKey;

  static void storeDynamicVariables(
      dynamic data, GlobalKey<FormState> formKey) {
    if (data != null && data is Map) {
      for (var i = 0; i < data.entries.length; i++) {
        final element = data.entries.elementAt(i);
        if (element.value != null) {
          String key = element.key;
          if (formKey != null)
            key = key.replaceAll('${formKey.hashCode.toString()}_', '');
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
          SmeupVariablesService.setVariable(key, value, formKey: formKey);
        }
      }
    }
  }

  static void storeFormVariables(Map data, GlobalKey<FormState> formKey) {
    if (data != null && data['name'] != null) {
      String type = data['type'];
      if (type == null || type.toString() != 'sch') {
        SmeupVariablesService.setVariable(data['name'], data['value'] ?? '',
            formKey: null);
      } else {
        SmeupVariablesService.setVariable(data['name'], data['value'] ?? '',
            formKey: formKey);
      }
    }
  }

  static Future<void> run(
      List dynamisms,
      BuildContext context,
      String event,
      GlobalKey<ScaffoldState> scaffoldKey,
      GlobalKey<FormState> formKey) async {
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
            value = SmeupVariablesService.getVariable(varName, formKey: formKey)
                .toString();
          } else {
            value = element['value'];
          }
          var newEl = {
            "name": element['name'],
            "type": element['type'],
            "value": value
          };
          SmeupDynamismService.storeFormVariables(newEl, formKey);
        });
      }

      if (dynamism['exec'] != null) {
        String exec =
            SmeupDynamismService.replaceFunVariables(dynamism['exec'], formKey);

        if (exec.toLowerCase() == 'close') {
          Navigator.of(context).pop();
          return;
        }

        SmeupFun smeupFunExec = SmeupFun(exec, formKey);
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
        SmeupWidgetNotificationService.notifyWidgets(
            targets, context, scaffoldKey.hashCode);
      }
    }
  }

  static _showDialog(SmeupFun smeupFunExec, BuildContext context, String notify,
      GlobalKey<ScaffoldState> scaffoldKey) {
    showDialog(
        barrierDismissible: false,
        routeSettings: RouteSettings(arguments: {
          'smeupFun': smeupFunExec,
          'isDialog': true,
          'backButtonVisible': false
        }),
        context: context,
        builder: (_) => SimpleDialog(
              contentPadding: EdgeInsets.only(top: 20, bottom: 20),
              backgroundColor:
                  SmeupConfigurationService.getTheme().scaffoldBackgroundColor,
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

  static String replaceFunVariables(
      String funString, GlobalKey<FormState> formKey) {
    SmeupVariablesService.getVariables(formKey: formKey)
        .entries
        .forEach((element) {
      String key = element.key;
      if (formKey != null)
        key = key.replaceAll('${formKey.hashCode.toString()}_', '');

      if (element.value is String) {
        funString =
            funString.replaceAll('[$key]', element.value.toString() ?? '');
      } else {
        funString =
            funString.replaceAll('\"[$key]\"', element.value.toString() ?? '');
      }
    });
    try {
      // remove not replacable variable
      RegExp re = RegExp(r'\[[^\]]*\]');
      String newFun = funString;
      re.allMatches(funString).forEach((match) {
        final value = funString
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
      funString = newFun;
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in replaceFunVariables: $funString ',
          logType: LogType.error);
    }
    return funString;
  }

  static _manageNotify(
      String notify, BuildContext context, int scaffoldHashCode) {
    if (notify != null && notify.isNotEmpty) {
      var widgetsIds = notify.toString().split('\\');
      if (widgetsIds.length > 0) {
        SmeupWidgetNotificationService.notifyWidgets(
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

            Color backColor;
            switch (severity) {
              case LogType.error:
                backColor = SmeupConfigurationService.getTheme().errorColor;
                break;
              case LogType.warning:
                backColor = Colors.orange;
                break;
              default:
                backColor = Colors.green;
            }

            if (text.isNotEmpty) {
              switch (mode) {
                case MessagesPromptMode.snackbar:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(text,
                          style: TextStyle(
                              color: SmeupConfigurationService.getTheme()
                                  .textTheme
                                  .bodyText2
                                  .color)),
                      backgroundColor: backColor,
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
