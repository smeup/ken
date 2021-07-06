class SmeupChartColumn {
  String name;
  String title;
  String size;
  String fill;

  SmeupChartColumn.fromInfluxDB(this.name, this.title, this.size);

  SmeupChartColumn.fromJson(Map<String, dynamic> jsonMap) {
    fill = jsonMap['fill'];
    name = jsonMap['code'];
    title = jsonMap['text'];
    size = jsonMap['lun'];
  }
}
