import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';

class SmeupWidgetNotificationService {
  static List<dynamic> objects = List<dynamic>.empty(growable: true);

  static void notifyWidgets(
      List<String> widgetsIds, BuildContext context, int scaffoldHashCode) {
    for (var i = 0; i < widgetsIds.length; i++) {
      final widgetId = widgetsIds[i];

      if (widgetId.toLowerCase().contains('close(')) {
        String routeName = '';

        try {
          RegExp re = RegExp(r'\([^)]*\)');
          Match firstMatch = re.firstMatch(widgetId);
          if (firstMatch != null) {
            routeName = widgetId
                .substring(firstMatch.start, firstMatch.end)
                .replaceFirst('(', '')
                .replaceFirst(')', '');
          }
        } catch (e) {
          SmeupLogService.writeDebugMessage(
              'Error in notifyWidgets: routeName not working in $widgetId',
              logType: LogType.error);
        }

        if (routeName.isNotEmpty)
          Navigator.of(context).pushNamedAndRemoveUntil(
              '/$routeName', (Route<dynamic> route) => false);
        else
          Navigator.of(context).pop();
      } else if (widgetId.toLowerCase() == 'yes') {
        SmeupWidgetNotificationService._invokeFunction(
            scaffoldHashCode.toString());
      } else {
        SmeupWidgetNotificationService._invokeFunction(widgetId);
      }
    }
  }

  static void _invokeFunction(widgetId) {
    final sels = SmeupWidgetNotificationService.objects
        .where((element) => element['id'] == widgetId)
        .toList();
    if (sels == null) return;

    for (var i = 0; i < sels.length; i++) {
      var sel = sels[i];
      sel['dataLoaded'] = false;

      Function notifierFunction = sel['notifierFunction'];
      if (notifierFunction != null) notifierFunction();
    }
  }

  // static void setTimerRefresh(widgetId) {
  //   final sel = objects.firstWhere((element) => element['id'] == widgetId,
  //       orElse: () => null);
  //   if (sel == null) return;
  //   SmeupModel smeupModel = sel['model'];
  //   if (smeupModel == null) return;
  //   if (smeupModel.refresh > 0 && sel['notifierFunction'] != null) {
  //     Timer(Duration(seconds: smeupModel.refresh), () {
  //       Function notifierFunction = sel['notifierFunction'];
  //       try {
  //         notifierFunction();
  //         SmeupLogService.writeDebugMessage(
  //             'notified ${smeupModel.type}: ${smeupModel.id}',
  //             logType: LogType.info);
  //       } catch (e) {
  //         SmeupLogService.writeDebugMessage(
  //             'Error widgetId refresh: ${e.toString()}',
  //             logType: LogType.error);
  //       }
  //     });
  //   }
  // }
}
