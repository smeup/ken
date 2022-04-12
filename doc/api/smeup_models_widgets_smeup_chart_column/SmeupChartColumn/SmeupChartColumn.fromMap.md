


# SmeupChartColumn.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupChartColumn.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap)





## Implementation

```dart
SmeupChartColumn.fromMap(Map<String, dynamic> jsonMap) {
  type = _getColumnType(jsonMap['fill']);
  name = jsonMap['code'];
  title = jsonMap['text'];
  size = SmeupUtilities.getInt(jsonMap['lun']);
}
```







