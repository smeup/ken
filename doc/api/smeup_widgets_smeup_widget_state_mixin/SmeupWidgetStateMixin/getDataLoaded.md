


# getDataLoaded method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? getDataLoaded
(dynamic id)








## Implementation

```dart
bool? getDataLoaded(id) {
  final sel = SmeupWidgetNotificationService.objects
      .firstWhere((element) => element['id'] == id, orElse: () => null);
  return sel['dataLoaded'];
}
```







