


# getHolidays method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[DateTime](https://api.flutter.dev/flutter/dart-core/DateTime-class.html), [List](https://api.flutter.dev/flutter/dart-core/List-class.html)?>> getHolidays
([int](https://api.flutter.dev/flutter/dart-core/int-class.html) year, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? country)








## Implementation

```dart
Future<Map<DateTime, List?>> getHolidays(int year, String? country) async {
  var holidays = Map<DateTime, List?>();
  Function addHoliday = (DateTime date, String description) {
    List? holidayList;

    DateTime key = DateTime(date.year, date.month, date.day);

    if (holidays[key] == null)
      holidayList = List<String>.empty(growable: true);
    else
      holidayList = holidays[key];

    holidayList!.add(description);
    holidays[key] = holidayList;
  };

  final listPublic = await _getPublicHolidaysFromNager(year, country);
  listPublic.forEach((holiday) {
    DateTime? date = DateTime.tryParse(holiday['date']);
    String? description = holiday['localName'];
    addHoliday(date, description);
  });

  final listCustom = await _getCustomHolidays();
  listCustom.forEach((holiday) {
    DateTime? date = DateTime.tryParse(holiday['date']);
    String? description = holiday['description'];
    addHoliday(date, description);
  });

  //print(listPublic);
  //print(listCustom);
  return holidays;
}
```







