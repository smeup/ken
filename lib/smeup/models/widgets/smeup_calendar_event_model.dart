import 'dart:ui';

import 'package:flutter/material.dart';

class SmeupCalentarEventModel {
  DateTime day;
  String description;
  Color backgroundColor = Color.fromRGBO(224, 226, 109, 1);
  Color foreColor = Colors.black;
  FontWeight fontWeight = FontWeight.normal;

  SmeupCalentarEventModel(this.day, this.description);

  SmeupCalentarEventModel.fromMap(dynamic fields, String titleColumnName,
      String dataColumnName, String styleColumnName) {
    this.day = DateTime.parse('${fields[dataColumnName]} 00:00:00.000Z');
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
}
