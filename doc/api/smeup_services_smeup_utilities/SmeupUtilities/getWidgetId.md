


# getWidgetId method








[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getWidgetId
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) type, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id)








## Implementation

```dart
static String getWidgetId(String type, String id) {
  if (type == null || type.isEmpty) type = '';
  if (id == null || id.isEmpty) id = '';
  String newId = id;

  if (newId.isEmpty) {
    // SmeupLogService.writeDebugMessage('getWidgetId. type: $type',
    //     logType: LogType.debug);
    newId = id.isNotEmpty
        ? id
        : getRandom(type, ''); //type + Random().nextInt(10000).toString();
    while (SmeupWidgetNotificationService.objects.firstWhere(
            (element) => element['id'] == newId,
            orElse: () => null) !=
        null) {
      newId = getRandom(type, id);
    }
  }

  return newId;
}
```







