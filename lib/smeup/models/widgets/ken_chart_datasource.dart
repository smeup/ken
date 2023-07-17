import 'dart:convert';

import 'ken_chart_column.dart';
import 'ken_chart_row.dart';

class KenChartDatasource {
  List<KenChartColumn>? columns;
  List<KenChartRow>? rows;

  KenChartDatasource(this.rows, this.columns);

  KenChartDatasource.fromMap(Map<String, dynamic> jsonData) {
    columns = List<KenChartColumn>.empty(growable: true);
    rows = List<KenChartRow>.empty(growable: true);

    if (jsonData['columns'] != null &&
        (jsonData['columns'] as List).isNotEmpty) {
      jsonData['columns']
          .forEach((c) => columns!.add(KenChartColumn.fromMap(c)));
      jsonData['rows']
          .forEach((r) => rows!.add(KenChartRow.fromMap(r, columns!)));
    }
  }

  KenChartDatasource.fromInfluxDB(String script) {
    Map<String, dynamic> jsonMap = json.decode(script);
    List<dynamic> jsonResults = jsonMap['results'];
    final jsonResult = jsonResults[0];
    List<dynamic> jsonSeries = jsonResult["series"];
    final jsonData = jsonSeries[0];
    List<dynamic> jsonColumns = jsonData["columns"];
    List<dynamic> jsonValues = jsonData["values"];

    columns = List<KenChartColumn>.empty(growable: true);
    jsonColumns.forEach((c) {
      columns!.add(KenChartColumn.fromInfluxDB(c, c, 0));
    });

    rows = List<KenChartRow>.empty(growable: true);
    jsonValues.forEach((r) {
      rows!.add(KenChartRow.fromInfluxDB(r, columns!));
    });
  }
}
