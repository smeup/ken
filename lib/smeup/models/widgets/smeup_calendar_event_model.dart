import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SmeupCalentarEventModel {
  DateTime day;
  String description;
  Color backgroundColor = Color.fromRGBO(224, 226, 109, 1);
  Color foreColor = Colors.black;
  FontWeight fontWeight = FontWeight.normal;
  DateTime initTime;
  DateTime endTime;

  SmeupCalentarEventModel(
      this.day, this.description, this.initTime, this.endTime);

  SmeupCalentarEventModel.fromMap(
      dynamic fields,
      String titleColumnName,
      String dataColumnName,
      String styleColumnName,
      String initColumnName,
      String endColumnName) {
    this.day = DateFormat('dd/MM/yyyy')
        .parse('${fields[dataColumnName].toString()} 00:00:00.000');
    this.initTime = _toTime(fields[initColumnName]);
    this.endTime = _toTime(fields[endColumnName]);
    this.description = fields[titleColumnName];
    dynamic styleColValue = fields[styleColumnName];

    switch (styleColValue) {
      case '50G00':
        backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
        foreColor = Colors.white;
        fontWeight = FontWeight.normal;
        break;
      case '00H00':
        backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
        foreColor = Colors.black;
        fontWeight = FontWeight.normal;
        break;
      case '51G00':
        backgroundColor = Color.fromRGBO(6, 138, 156, 1); // dark green
        foreColor = Colors.white;
        fontWeight = FontWeight.bold;
        break;
      case '01H00':
        backgroundColor = Color.fromRGBO(148, 197, 154, 1); // clear green
        foreColor = Colors.black;
        fontWeight = FontWeight.bold;
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
