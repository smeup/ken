


# SmeupChartRow.fromMap constructor







SmeupChartRow.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) jsonData, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupChartColumn](../../smeup_models_widgets_smeup_chart_column/SmeupChartColumn-class.md)> _columns)





## Implementation

```dart
SmeupChartRow.fromMap(Map jsonData, this._columns) {
  cells = List<dynamic>.empty(growable: true);
  for (SmeupChartColumn col in _columns) {
    cells.add(jsonData[col.name]);
  }
}
```







