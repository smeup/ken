


# middleStringAtIndex method








[String](https://api.flutter.dev/flutter/dart-core/String-class.html) middleStringAtIndex
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) index)

_override_






## Implementation

```dart
String middleStringAtIndex(int index) {
  if (this.middleList == null) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  } else {
    if (index >= 0 && index < middleList.length) {
      return middleList[index];
    } else {
      return null;
    }
  }
}
```







