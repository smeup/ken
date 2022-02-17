


# getInitialLastWork method








[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) getInitialLastWork
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) focusedDay)








## Implementation

```dart
static DateTime getInitialLastWork(DateTime focusedDay) {
  var dt = DateTime(focusedDay.year + 2, focusedDay.month, 0);

  return dt;
}
```







