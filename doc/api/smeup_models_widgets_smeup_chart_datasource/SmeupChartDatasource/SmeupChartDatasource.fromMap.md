


# SmeupChartDatasource.fromMap constructor







SmeupChartDatasource.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonData)





## Implementation

```dart
SmeupChartDatasource.fromMap(Map<String, dynamic> jsonData) {
  columns = List<SmeupChartColumn>.empty(growable: true);
  rows = List<SmeupChartRow>.empty(growable: true);

  if (jsonData['columns'] != null &&
      (jsonData['columns'] as List).length > 0) {
    jsonData['columns']
        .forEach((c) => columns.add(SmeupChartColumn.fromMap(c)));
    jsonData['rows']
        .forEach((r) => rows.add(SmeupChartRow.fromMap(r, columns)));
  }
}
```







