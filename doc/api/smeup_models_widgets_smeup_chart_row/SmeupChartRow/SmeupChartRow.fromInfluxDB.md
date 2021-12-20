


# SmeupChartRow.fromInfluxDB constructor







SmeupChartRow.fromInfluxDB([List](https://api.flutter.dev/flutter/dart-core/List-class.html) jsonMap, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupChartColumn](../../smeup_models_widgets_smeup_chart_column/SmeupChartColumn-class.md)> _columns)





## Implementation

```dart
SmeupChartRow.fromInfluxDB(List<dynamic> jsonMap, this._columns) {
  cells = List<dynamic>.empty(growable: true);
  for (var i = 0; i < _columns.length; i++) {
    var jsonValue = jsonMap[i];
    if (jsonValue == null) jsonValue = 0;

    double cellValue = 0;
    if (jsonValue is double)
      cellValue = jsonValue;
    else if (jsonValue is int)
      cellValue = double.parse(jsonValue.toString());
    else
      cellValue = double.parse(jsonValue);

    cells.add(cellValue);
  }
}
```







