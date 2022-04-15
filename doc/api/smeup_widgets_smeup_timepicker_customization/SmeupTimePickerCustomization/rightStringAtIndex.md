


# rightStringAtIndex method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? rightStringAtIndex
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) index)

_override_






## Implementation

```dart
@override
String? rightStringAtIndex(int index) {
  if (index >= 0 && index < 60) {
    return this.digits(index, 2);
  } else {
    return null;
  }
}
```







