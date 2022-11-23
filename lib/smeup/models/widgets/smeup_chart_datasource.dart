import 'dart:convert';

import 'package:ken/smeup/models/widgets/smeup_chart_column.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_row.dart';

class SmeupChartDatasource {
  List<SmeupChartColumn>? columns;
  List<SmeupChartRow>? rows;

  SmeupChartDatasource(this.rows, this.columns);

  SmeupChartDatasource.fromMap(Map<String, dynamic> jsonData) {
    columns = List<SmeupChartColumn>.empty(growable: true);
    rows = List<SmeupChartRow>.empty(growable: true);

    if (jsonData['columns'] != null &&
        (jsonData['columns'] as List).length > 0) {
      jsonData['columns']
          .forEach((c) => columns!.add(SmeupChartColumn.fromMap(c)));
      jsonData['rows']
          .forEach((r) => rows!.add(SmeupChartRow.fromMap(r, columns!)));
    }
  }

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
}
