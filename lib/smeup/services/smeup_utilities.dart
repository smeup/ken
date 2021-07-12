import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

class SmeupUtilities {
  static String extractValueFromType(
      Map fields, String tipo, String parametro) {
    Map retField;
    for (var i = 0; i < fields.entries.length; i++) {
      final element = fields.entries.elementAt(i);
      if (element.value['smeupObject']['tipo'] == tipo &&
          element.value['smeupObject']['parametro'] == parametro) {
        retField = fields[element.key];
        break;
      }
    }
    return extractValueFromName(retField);
  }

  static String extractValueFromName(Map field) {
    String fieldValue;
    Map smeupObject = field['smeupObject'];
    if (smeupObject != null) {
      switch (smeupObject['tipo']) {
        case 'NR':
          if (smeupObject['codice'].toString().trim() == '')
            fieldValue = '0';
          else
            fieldValue = smeupObject['codice'].toString().trim();
          break;
        default:
          fieldValue = smeupObject['codice'];
      }
    }
    return fieldValue;
  }

  static Color getColorFromRGB(String color, {double opacity = 1.0}) {
    final split = color.split(RegExp(r"(?=[A-Z])"));
    if (split == null || split.length != 3)
      return SmeupOptions.theme.textTheme.headline6.color;

    int r = int.parse(split[0].substring(1));
    int g = int.parse(split[1].substring(1));
    int b = int.parse(split[2].substring(1));

    return Color.fromRGBO(r, g, b, opacity);
  }

  static bool isNumeric(String s) {
    if (s == null) {
      return false;
    }
    return (int.tryParse(s) ?? null) != null;
  }

  static double getDouble(dynamic value) {
    if (value is double) {
      return value;
    } else if (value is String) {
      return double.tryParse(value);
    }
    if (value is int) {
      return value.toDouble();
    }
    return value;
  }
}
