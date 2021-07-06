import 'dart:convert';

import 'package:mobile_components_library/smeup/models_components/smeup_chart_model.dart';
import 'package:mobile_components_library/smeup/models/smeupChartColumn.dart';
import 'package:mobile_components_library/smeup/models/smeupChartRow.dart';

class SmeupChartDatasource {
  List<SmeupChartColumn> columns;
  List<SmeupChartRow> rows;
  String chartType;
  int refreshMilliseconds = -1;

  SmeupChartDatasource.fromJson(
      SmeupChartModel smeupChartModel, dynamic script) {
    setOptions(smeupChartModel);

    Map<String, dynamic> jsonData = script;

    columns = List<SmeupChartColumn>.empty(growable: true);
    jsonData['columns']
        .forEach((c) => columns.add(SmeupChartColumn.fromJson(c)));

    rows = List<SmeupChartRow>.empty(growable: true);
    jsonData['rows']
        .forEach((r) => rows.add(SmeupChartRow.fromJson(r, columns)));
  }

  SmeupChartDatasource.fromInfluxDB(
      SmeupChartModel smeupChartModel, String script) {
    setOptions(smeupChartModel);

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

  List<SmeupGraphData> getDataTable(int xCol, int yCol, int filterCol,
      Function filterFunction, String filterValue) {
    List<SmeupGraphData> datatable;
    datatable = List<SmeupGraphData>.empty(growable: true);

    rows.forEach((f) {
      double x = 0;
      if (f.cells[xCol] is double)
        x = f.cells[xCol];
      else
        x = double.parse(f.cells[xCol].toString());

      double y = 0;
      if (f.cells[yCol] is double)
        y = f.cells[yCol];
      else
        y = double.parse(f.cells[yCol].toString());

      String valueToTest;
      if (filterCol >= 0) valueToTest = f.cells[filterCol].toString();

      if (filterFunction == null ||
          filterCol >= 0 &&
              filterFunction != null &&
              filterFunction(valueToTest, filterValue))
        datatable.add(SmeupGraphData(x, y));
    });

    return datatable;
  }

  void setOptions(SmeupChartModel smeupChartModel) {
    if (smeupChartModel.options != null) {
      if (smeupChartModel.options['CHA'] != null) {
        if (smeupChartModel.options['CHA']['default'] != null) {
          if (smeupChartModel.options['CHA']['default']['refresh'] != null)
            refreshMilliseconds =
                smeupChartModel.options['CHA']['default']['refresh'];
          if (smeupChartModel.options['CHA']['default']['types'] != null)
            chartType = smeupChartModel.options['CHA']['default']['types'][0];
        }
      }
    }
  }
}

class SmeupGraphData {
  double x;
  double y;

  SmeupGraphData(this.x, this.y);
}
