// ignore_for_file: unnecessary_string_interpolations

import 'package:flutter/material.dart';

class KenCalendarEventModel {
  Color backgroundColor = const Color.fromRGBO(224, 226, 109, 1);
  Color fontColor = Colors.black;
  FontWeight fontWeight = FontWeight.normal;
  Color markerBackgroundColor = Colors.blue;
  Color markerFontColor = Colors.black;

  DateTime? day;
  String? description;
  DateTime? initTime;
  DateTime? endTime;
  late dynamic fields;

  KenCalendarEventModel(
      this.day, this.description, this.initTime, this.endTime);

  KenCalendarEventModel.fromMap(
      this.fields,
      String? titleColumnName,
      String? dataColumnName,
      String? styleColumnName,
      String? initColumnName,
      String? endColumnName) {
    day = DateTime.parse(fields[dataColumnName].toString());
    initTime = _toTime(fields[initColumnName]);
    endTime = _toTime(fields[endColumnName]);
    description = fields[titleColumnName] ?? '';
    String style = fields[styleColumnName] ?? '';

    switch (style) {
      case 'secondary': // secondary
        backgroundColor = const Color.fromRGBO(6, 137, 155, 1); // primary dark
        fontColor = Colors.black;
        fontWeight = FontWeight.normal;
        markerBackgroundColor =
            const Color.fromRGBO(255, 186, 69, 1); // secondary light
        markerFontColor = Colors.black;
        break;
      default: // primary
        backgroundColor =
            const Color.fromRGBO(255, 186, 69, 1); // secondary light
        fontColor = Colors.black;
        fontWeight = FontWeight.normal;
        markerBackgroundColor =
            const Color.fromRGBO(0, 92, 109, 1); // primary dark
        markerFontColor = Colors.white;
        break;
    }
  }

  DateTime? _toTime(String? timeStr) {
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
