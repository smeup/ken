


# setDataLoad method








void setDataLoad
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) value)








## Implementation

```dart
void setDataLoad(String id, bool value) {
  var sel = SmeupWidgetNotificationService.objects
      .firstWhere((element) => element['id'] == id, orElse: () => null);
  sel['dataLoaded'] = value;
  SmeupWidgetNotificationService.objects
      .removeWhere((element) => element['id'] == id);
  SmeupWidgetNotificationService.objects.add(sel);
}
```







