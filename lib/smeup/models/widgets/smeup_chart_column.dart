import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum ColumnType { Axes, Series }

class SmeupChartColumn {
  String name;
  String title;
  int size;
  ColumnType type;

  SmeupChartColumn(this.name, this.title, this.type, this.size);

  SmeupChartColumn.fromMap(Map<String, dynamic> jsonMap) {
    type = _getColumnType(jsonMap['fill']);
    name = jsonMap['value'];
    title = jsonMap['text'];
    size = SmeupUtilities.getInt(jsonMap['lun']);
  }

  _getColumnType(String fill) {
    switch (fill) {
      case 'axes':
        return ColumnType.Axes;
        break;
      case 'series':
        return ColumnType.Series;
        break;
      default:
        return null;
    }
  }

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
