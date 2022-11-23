


# digits method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) digits
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) value, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) length)








## Implementation

```dart
String digits(int value, int length) {
  return '$value'.padLeft(length, "0");
}
```







