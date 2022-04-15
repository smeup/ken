


# isDinamismAsync method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isDinamismAsync
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) event, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Dynamism](../../smeup_models_dynamism/Dynamism-class.md)> dynamisms)








## Implementation

```dart
static bool isDinamismAsync(String event, List<Dynamism> dynamisms) {
  int no = dynamisms.where((element) => element.event == event).length;

  if (no > 0) {
    Dynamism dynamism =
        dynamisms.where((element) => element.event == event).first;
    return dynamism.async;
  }

  return false;
}
```







