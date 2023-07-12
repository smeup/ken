import '../../services/ken_utilities.dart';

enum ColumnType { Axes, Series }

class KenChartColumn {
  String? name;
  String? title;
  int? size;
  ColumnType? type;

  KenChartColumn(this.name, this.title, this.type, this.size);

  KenChartColumn.fromMap(Map<String, dynamic> jsonMap) {
    type = _getColumnType(jsonMap['fill']);
    name = jsonMap['code'];
    title = jsonMap['text'];
    size = KenUtilities.getInt(jsonMap['lun']);
  }

  _getColumnType(String? fill) {
    switch (fill) {
      case 'ASSE':
        return ColumnType.Axes;
      case 'SERIE':
        return ColumnType.Series;
      default:
        return null;
    }
  }

  KenChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
