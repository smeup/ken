import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupWidgetNotifier with ChangeNotifier {
  List<dynamic> objects = List<dynamic>.empty(growable: true);

  static var widgets = Map<String, dynamic>();

  static void addWidget(
      int scaffoldHashCode, String componentId, String type, dynamic notifier) {
    if (type == null) return;
    final notifierKey = _getNotifierKey(scaffoldHashCode, componentId);
    SmeupWidgetNotifier.widgets[notifierKey] = notifier;
  }

  static void removeWidget(int scaffoldHashCode, String componentId) {
    final notifierKey = _getNotifierKey(scaffoldHashCode, componentId);
    SmeupWidgetNotifier.widgets.removeWhere((key, value) => key == notifierKey);
  }

  static String _getNotifierKey(int scaffoldHashCode, String componentId) {
    return '${scaffoldHashCode}_$componentId'.toLowerCase();
  }

  static void notifyWidgets(
      List<String> widgetsIds, BuildContext context, int scaffoldHashCode) {
    widgetsIds.forEach((widgetId) {
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
        final notifierKey =
            _getNotifierKey(scaffoldHashCode, scaffoldHashCode.toString());
        final notifier = SmeupWidgetNotifier.widgets[notifierKey];
        notifier.changeWidgets(widgetId);
      } else {
        final notifierKey = _getNotifierKey(scaffoldHashCode, widgetId);
        final notifier = SmeupWidgetNotifier.widgets[notifierKey];
        if (notifier != null) notifier.changeWidgets(widgetId);
      }
    });
  }

  void changeWidgets(widgetId) {
    final sel = objects.firstWhere((element) => element['id'] == widgetId,
        orElse: () => null);
    if (sel == null) return;
    // SmeupModel smeupModel = sel['model'];
    // smeupModel.load = '';

    Function notifierFunction = sel['notifierFunction'];
    if (notifierFunction != null) notifierFunction();

    //notifyListeners();
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
