


# SmeupChartDatasource.fromInfluxDB constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupChartDatasource.fromInfluxDB([String](https://api.flutter.dev/flutter/dart-core/String-class.html) script)





## Implementation

```dart
SmeupChartDatasource.fromInfluxDB(String script) {
  Map<String, dynamic> jsonMap = json.decode(script);
  List<dynamic> jsonResults = jsonMap['results'];
  final jsonResult = jsonResults[0];
  List<dynamic> jsonSeries = jsonResult["series"];
  final jsonData = jsonSeries[0];
  List<dynamic> jsonColumns = jsonData["columns"];
  List<dynamic> jsonValues = jsonData["values"];

  columns = List<SmeupChartColumn>.empty(growable: true);
  jsonColumns.forEach((c) {
    columns!.add(SmeupChartColumn.fromInfluxDB(c, c, 0));
  });

  rows = List<SmeupChartRow>.empty(growable: true);
  jsonValues.forEach((r) {
    rows!.add(SmeupChartRow.fromInfluxDB(r, columns!));
  });
}
```







