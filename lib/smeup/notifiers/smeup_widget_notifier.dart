import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:provider/provider.dart';

class SmeupWidgetNotifier with ChangeNotifier {
  List<dynamic> objects = List<dynamic>.empty(growable: true);

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
        var notifier = Provider.of<SmeupWidgetNotifier>(context, listen: false);
        notifier.changeWidgets(scaffoldHashCode.toString());
      } else {
        var notifier = Provider.of<SmeupWidgetNotifier>(context, listen: false);
        if (notifier != null) notifier.changeWidgets(widgetId);
      }
    }
  }

  void changeWidgets(widgetId) {
    final sel = objects.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    sel['dataLoaded'] = false;

    Function notifierFunction = sel['notifierFunction'];
    if (notifierFunction != null) notifierFunction();
  }

  void setTimerRefresh(widgetId) {
    final sel = objects.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    SmeupModel smeupModel = sel['model'];
    if (smeupModel == null) return;
    if (smeupModel.refresh > 0 && sel['notifierFunction'] != null) {
      Timer(Duration(seconds: smeupModel.refresh), () {
        Function notifierFunction = sel['notifierFunction'];
        try {
          notifierFunction();
          SmeupLogService.writeDebugMessage(
              'notified ${smeupModel.type}: ${smeupModel.id}',
              logType: LogType.info);
        } catch (e) {
          SmeupLogService.writeDebugMessage(
              'Error widgetId refresh: ${e.toString()}',
              logType: LogType.error);
        }
      });
    }
  }
}
