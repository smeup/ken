


# isValid method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isValid
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) statusCode)








## Implementation

```dart
static bool isValid(int statusCode) {
  if (statusCode >= 200 && statusCode < 300)
    return true;
  else
    return false;
}
```







