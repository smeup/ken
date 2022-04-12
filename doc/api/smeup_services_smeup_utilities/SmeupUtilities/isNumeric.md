


# isNumeric method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isNumeric
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) s)








## Implementation

```dart
static bool isNumeric(String s) {
  if (((int.tryParse(s) ?? null) != null) ||
      ((double.tryParse(s) ?? null) != null)) return true;

  return false;
}
```







