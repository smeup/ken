import 'dart:convert';

import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_column.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_row.dart';

class SmeupChartDatasource {
  List<SmeupChartColumn> columns;
  List<SmeupChartRow> rows;

  SmeupChartDatasource(this.rows, this.columns);

  SmeupChartDatasource.fromMap(Map<String, dynamic> jsonData) {
    columns = List<SmeupChartColumn>.empty(growable: true);
    jsonData['columns']
        .forEach((c) => columns.add(SmeupChartColumn.fromMap(c)));

    rows = List<SmeupChartRow>.empty(growable: true);
    jsonData['rows']
        .forEach((r) => rows.add(SmeupChartRow.fromMap(r, columns)));
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
      columns.add(SmeupChartColumn.fromInfluxDB(c, c, ''));
    });

    rows = List<SmeupChartRow>.empty(growable: true);
    jsonValues.forEach((r) {
      rows.add(SmeupChartRow.fromInfluxDB(r, columns));
    });
  }
}
