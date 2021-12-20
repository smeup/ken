


# isNumeric method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isNumeric
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) s)








## Implementation

```dart
static bool isNumeric(String s) {
  if (s == null) {
    return false;
  }

  if (((int.tryParse(s) ?? null) != null) ||
      ((double.tryParse(s) ?? null) != null)) return true;

  return false;
}
```







