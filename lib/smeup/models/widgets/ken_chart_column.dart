enum ColumnType { axes, series }

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
    size = _getInt(jsonMap['lun']);
  }

  int? _getInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value);
    }
    return value;
  }

  _getColumnType(String? fill) {
    switch (fill) {
      case 'ASSE':
        return ColumnType.axes;
      case 'SERIE':
        return ColumnType.series;
      default:
        return null;
    }
  }

  KenChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
