import 'package:ken/smeup/models/widgets/ken_chart_column.dart';

class KenChartRow {
  List<dynamic>? cells;
  late List<KenChartColumn> _columns;

  KenChartRow(this.cells);

  KenChartRow.fromMap(Map jsonData, this._columns) {
    cells = List<dynamic>.empty(growable: true);
    for (KenChartColumn col in _columns) {
      cells!.add(jsonData[col.name]);
    }
  }

  KenChartRow.fromInfluxDB(List<dynamic> jsonMap, this._columns) {
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

      cells!.add(cellValue);
    }
  }
}
