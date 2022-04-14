import 'dart:async';

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/dynamism.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_message_data_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/services/smeup_widget_notification_service.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/fun.dart';

class SmeupDynamismService {
  static const loggerId = "SmeupDynamismService";

  static void storeDynamicVariables(
      dynamic data, GlobalKey<FormState>? formKey) {
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
          // if (key == 'testo' || key == 'value') key = 'Tx';
          if (key == 'testo') key = 'Tx';
          if (key == 'nome') key = 'Nm';

          String? value = '';
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

  static void storeFormVariables(Map data, GlobalKey<FormState>? formKey) {
    if (data['name'] != null) {
      String? type = data['type'];
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
      List<Dynamism>? dynamisms,
      BuildContext context,
      String event,
      GlobalKey<ScaffoldState> scaffoldKey,
      GlobalKey<FormState>? formKey) async {
    if (dynamisms == null) return;

    List<Dynamism> selectedDynamisms =
        dynamisms.where((element) => element.event == event).toList();

    for (var i = 0; i < selectedDynamisms.length; i++) {
      final dynamism = selectedDynamisms[i];

      if (dynamism.variables.isNotEmpty) {
        dynamism.variables.forEach((element) {
          String? value = '';
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

      if (dynamism.exec.isNotEmpty) {
        String exec =
            SmeupDynamismService.replaceVariables(dynamism.exec, formKey);

        if (exec.toLowerCase() == 'close') {
          Navigator.of(context).pop();
          return;
        }

        Fun smeupFunExec = Fun(exec, formKey, scaffoldKey, context);
        String? notify = smeupFunExec.notify;

        switch (smeupFunExec.identifier.component) {
          case 'EXD':
            switch (smeupFunExec.identifier.service) {
              case '*ROUTE':
                // Pass SmeupFun reference to destination screen
                Navigator.pushNamed(
                    context, '/${smeupFunExec.getObjectByName('obj2').k}',
                    arguments: {'smeupFun': smeupFunExec});
                break;
              default:
                if (smeupFunExec.G == 'DLG') {
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
            switch (smeupFunExec.identifier.service.toString()) {
              case '*URL':
                String url = smeupFunExec.input;
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

            await SmeupMessageDataService.manageResponseMessage(
                context, smeupServiceResponse.result);
            if (smeupServiceResponse.succeded) {
              _manageNotify(notify, context, scaffoldKey.hashCode);
            } else {
              return;
            }

            break;
          default:
        }
      }

      if (dynamism.targets.isNotEmpty) {
        List<String> targets =
            dynamism.targets.map((e) => e.toString()).toList();
        SmeupWidgetNotificationService.notifyWidgets(
            targets, context, scaffoldKey.hashCode);
      }
    }
  }

  static _showDialog(Fun smeupFunExec, BuildContext context, String? notify,
      GlobalKey<ScaffoldState> scaffoldKey) {
    showDialog(
        barrierDismissible: false,
        routeSettings: RouteSettings(arguments: {
          'smeupFun': smeupFunExec,
          'isDialog': true,
          'backButtonVisible': false
        }),
        context: context,
        builder: (_) => Theme(
              data: SmeupConfigurationService.getTheme()!,
              child: SimpleDialog(
                contentPadding: EdgeInsets.only(top: 20, bottom: 20),
                // backgroundColor: SmeupConfigurationService.getTheme()
                //     .scaffoldBackgroundColor,
                // shape: RoundedRectangleBorder(
                //   borderRadius: BorderRadius.circular(20.0),
                // ),
                children: [
                  Container(
                      height: 300, width: 350, child: SmeupDynamicScreen())
                ],
              ),
            )).then((value) {
      _manageNotify(notify, context, scaffoldKey.hashCode);
    });
  }

  static String replaceVariables(
      String funString, GlobalKey<FormState>? formKey) {
    SmeupVariablesService.getVariables(formKey: formKey)
        .entries
        .forEach((element) {
      String key = element.key;
      if (formKey != null)
        key = key.replaceAll('${formKey.hashCode.toString()}_', '');

      // TODO: to verify. old case where user enclose the variable name between quotation marks
      // if (element.value is String) {
      //   funString = funString.replaceAll('[$key]', element.value.toString());
      // } else {
      //   funString =
      //       funString.replaceAll('\"[$key]\"', element.value.toString());
      // }
      funString = funString.replaceAll('[$key]', element.value.toString());
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
        if (value.isNotEmpty) {
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
      String? notify, BuildContext context, int scaffoldHashCode) {
    if (notify != null && notify.isNotEmpty) {
      var widgetsIds = notify.toString().split('\\');
      if (widgetsIds.length > 0) {
        SmeupWidgetNotificationService.notifyWidgets(
            widgetsIds, context, scaffoldHashCode);
      }
    }
  }
}
