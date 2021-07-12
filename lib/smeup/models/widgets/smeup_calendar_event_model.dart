import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupCalentarEventModel {
  DateTime day;
  String description;
  String branchCode;
  String branchDescription;
  bool iAmIncluded;
  Color backgroundColor = Color.fromRGBO(224, 226, 109, 1);
  Color foreColor = Colors.black;
  FontWeight fontWeight = FontWeight.normal;

  SmeupCalentarEventModel(this.day, this.description, this.branchCode);

  SmeupCalentarEventModel.fromMap(
      dynamic fields, String titcol, String datcol, String styleColumnName) {
    this.day = DateTime.parse('${fields[datcol]} 12:00:00.000Z');
    this.description = fields['codice'];

    dynamic styleCol = fields[styleColumnName];
    String styleColValue = '';

    if (styleCol != null)
      styleColValue =
          SmeupUtilities.extractValueFromName(fields[styleColumnName]);

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

    // if (description.contains(currentSpots.toString()))
    //   iAmIncluded = false;
    // else
    //   iAmIncluded = true;
  }
}
