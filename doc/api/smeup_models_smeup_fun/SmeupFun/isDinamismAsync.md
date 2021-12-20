


# isDinamismAsync method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isDinamismAsync
([List](https://api.flutter.dev/flutter/dart-core/List-class.html) dynamisms, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) event)








## Implementation

```dart
bool isDinamismAsync(List dynamisms, String event) {
  if (dynamisms == null) return true;

  Map dynamism = dynamisms.firstWhere((element) => element['event'] == event,
      orElse: () => null);

  if (dynamism == null) return true;

  if (dynamism['async'] == null ||
      !(dynamism['async'] is bool) ||
      dynamism['async'] == true) return true;

  return false;
}
```







