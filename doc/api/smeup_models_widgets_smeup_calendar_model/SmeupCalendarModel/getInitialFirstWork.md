


# getInitialFirstWork method








[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) getInitialFirstWork
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) focusedDay)








## Implementation

```dart
static DateTime getInitialFirstWork(DateTime focusedDay) {
  var dt = DateTime(focusedDay.year, focusedDay.month - 2);
  return dt;
}
```







