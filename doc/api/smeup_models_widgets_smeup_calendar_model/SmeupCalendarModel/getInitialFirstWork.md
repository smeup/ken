


# getInitialFirstWork method




    *[<Null safety>](https://dart.dev/null-safety)*




[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) getInitialFirstWork
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) focusedDay)








## Implementation

```dart
static DateTime getInitialFirstWork(DateTime focusedDay) {
  var dt = DateTime(focusedDay.year - 2, focusedDay.month);
  return dt;
}
```







