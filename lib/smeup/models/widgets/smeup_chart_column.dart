enum ColumnType { Axes, Series }

class SmeupChartColumn {
  String name;
  String title;
  String size;
  ColumnType type;

  SmeupChartColumn(this.name, this.title, this.type, this.size);

  SmeupChartColumn.fromMap(Map<String, dynamic> jsonMap) {
    type = jsonMap['fill'];
    name = jsonMap['code'];
    title = jsonMap['text'];
    size = jsonMap['lun'];
  }

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
