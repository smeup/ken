


# notifyWidgets method




    *[<Null safety>](https://dart.dev/null-safety)*




void notifyWidgets
([List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> widgetsIds, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) scaffoldHashCode)








## Implementation

```dart
static void notifyWidgets(
    List<String> widgetsIds, BuildContext context, int scaffoldHashCode) {
  for (var i = 0; i < widgetsIds.length; i++) {
    final widgetId = widgetsIds[i];

    if (widgetId.toLowerCase().contains('close(')) {
      String routeName = '';

      try {
        RegExp re = RegExp(r'\([^)]*\)');
        Match? firstMatch = re.firstMatch(widgetId);
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
```







