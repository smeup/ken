


# finalTime method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) finalTime
()

_override_






## Implementation

```dart
@override
DateTime finalTime() {
  return currentTime.isUtc
      ? DateTime.utc(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          this.currentLeftIndex(),
          this.currentMiddleIndex(),
          this.currentRightIndex())
      : DateTime(
          currentTime.year,
          currentTime.month,
          currentTime.day,
          this.currentLeftIndex(),
          int.parse(this.middleList[this.currentMiddleIndex()]),
          this.currentRightIndex());
}
```







