


# leftStringAtIndex method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? leftStringAtIndex
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) index)

_override_






## Implementation

```dart
@override
String? leftStringAtIndex(int index) {
  if (index >= 0 && index < 24) {
    return this.digits(index, 2);
  } else {
    return null;
  }
}
```







