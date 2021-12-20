


# getInitialLastWork method








[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) getInitialLastWork
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) focusedDay)








## Implementation

```dart
static DateTime getInitialLastWork(DateTime focusedDay) {
  var dt = DateTime(focusedDay.year, focusedDay.month + 2, 0);

  return dt;
}
```







