import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupWidgetsNotifier {
  static var widgets = Map<String, dynamic>();

  static void addWidget(
      int scaffoldHashCode, String componentId, String type, dynamic notifier) {
    if (type == null) return;
    final notifierKey = _getNotifierKey(scaffoldHashCode, componentId);
    SmeupWidgetsNotifier.widgets[notifierKey] = notifier;
  }

  static void removeWidget(int scaffoldHashCode, String componentId) {
    final notifierKey = _getNotifierKey(scaffoldHashCode, componentId);
    SmeupWidgetsNotifier.widgets
        .removeWhere((key, value) => key == notifierKey);
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
        final notifier = SmeupWidgetsNotifier.widgets[notifierKey];
        notifier.changeWidgets(widgetId);
      } else {
        final notifierKey = _getNotifierKey(scaffoldHashCode, widgetId);
        final notifier = SmeupWidgetsNotifier.widgets[notifierKey];
        if (notifier != null) notifier.changeWidgets(widgetId);
      }
    });
  }
}
