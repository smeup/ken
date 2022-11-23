


# getStartFunDate method




    *[<Null safety>](https://dart.dev/null-safety)*




[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) getStartFunDate
([DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html) focusedDay)








## Implementation

```dart
static DateTime getStartFunDate(DateTime focusedDay) {
  var dt = DateTime(focusedDay.year, focusedDay.month);
  return dt;
}
```







