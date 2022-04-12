


# middleStringAtIndex method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? middleStringAtIndex
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) index)

_override_






## Implementation

```dart
String? middleStringAtIndex(int index) {
  if (index >= 0 && index < middleList.length) {
    return middleList[index];
  } else {
    return null;
  }
}
```







