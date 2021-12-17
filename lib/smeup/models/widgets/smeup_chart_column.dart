import 'package:ken/smeup/services/smeup_utilities.dart';

enum ColumnType { Axes, Series }

class SmeupChartColumn {
  String name;
  String title;
  int size;
  ColumnType type;

  SmeupChartColumn(this.name, this.title, this.type, this.size);

  SmeupChartColumn.fromMap(Map<String, dynamic> jsonMap) {
    type = _getColumnType(jsonMap['fill']);
    name = jsonMap['code'];
    title = jsonMap['text'];
    size = SmeupUtilities.getInt(jsonMap['lun']);
  }

  _getColumnType(String fill) {
    switch (fill) {
      case 'ASSE':
        return ColumnType.Axes;
        break;
      case 'SERIE':
        return ColumnType.Series;
        break;
      default:
        return null;
    }
  }

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
