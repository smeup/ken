class SmeupChartColumn {
  String name;
  String title;
  String size;
  String fill;

  SmeupChartColumn(this.name, this.title, this.fill, this.size);

  SmeupChartColumn.fromMap(Map<String, dynamic> jsonMap) {
    fill = jsonMap['fill'];
    name = jsonMap['code'];
    title = jsonMap['text'];
    size = jsonMap['lun'];
  }

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);
}
