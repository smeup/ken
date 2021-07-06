import 'package:mobile_components_library/smeup/models/smeupChartColumn.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupChartRow {
  List<dynamic> cells;
  List<SmeupChartColumn> _columns;

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

  SmeupChartRow.fromJson(Map<String, dynamic> jsonMap, this._columns) {
    cells = List<dynamic>.empty(growable: true);
    for (SmeupChartColumn col in _columns) {
      cells.add(
          SmeupUtilities.extractValueFromName(jsonMap['fields'][col.name]));
    }
  }
}
