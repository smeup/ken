import 'package:flutter/material.dart';

class SmeupCalentarEventModel {
  Color backgroundColor = Color.fromRGBO(224, 226, 109, 1);
  Color fontColor = Colors.black;
  FontWeight fontWeight = FontWeight.normal;
  Color markerBackgroundColor = Colors.blue;
  Color markerFontColor = Colors.black;

  DateTime day;
  String description;
  DateTime initTime;
  DateTime endTime;
  dynamic fields;

  SmeupCalentarEventModel(
      this.day, this.description, this.initTime, this.endTime);

  SmeupCalentarEventModel.fromMap(
      this.fields,
      String titleColumnName,
      String dataColumnName,
      String styleColumnName,
      String initColumnName,
      String endColumnName) {
    this.day = DateTime.parse(fields[dataColumnName].toString());
    this.initTime = _toTime(fields[initColumnName]);
    this.endTime = _toTime(fields[endColumnName]);
    this.description = fields[titleColumnName] ?? '';
    String style = fields[styleColumnName] ?? '';

    switch (style) {
      case '50G00':
        backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
        fontColor = Colors.white;
        fontWeight = FontWeight.normal;
        markerBackgroundColor = Colors.amber;
        markerFontColor = Colors.black;
        break;
      case '00H00':
        backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
        fontColor = Colors.black;
        fontWeight = FontWeight.normal;
        markerBackgroundColor = Colors.lime;
        markerFontColor = Colors.black;
        break;
      case '51G00':
        backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
        fontColor = Colors.white;
        fontWeight = FontWeight.bold;
        markerBackgroundColor = Colors.amber;
        markerFontColor = Colors.black;
        break;
      case '01H00':
        backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
        fontColor = Colors.black;
        fontWeight = FontWeight.bold;
        markerBackgroundColor = Colors.lime;
        markerFontColor = Colors.black;
        break;
      default:
    }
  }

  DateTime _toTime(String timeStr) {
    if (timeStr != null && timeStr.length >= 4) {
      String parsableTime =
          "19700101 ${timeStr.substring(0, 2)}:${timeStr.substring(2, 4)}";
      if (timeStr.length >= 6) {
        parsableTime += "${timeStr.substring(6, 6)}";
      }
      return DateTime.parse(parsableTime);
    } else {
      return null;
    }
  }

  @override
  String toString() {
    return "{day:$day, description:$description, initTime:$initTime, endTime:$endTime}";
  }
}
