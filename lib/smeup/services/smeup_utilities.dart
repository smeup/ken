import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

import 'smeup_widget_notification_service.dart';

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

    if (((int.tryParse(s) ?? null) != null) ||
        ((double.tryParse(s) ?? null) != null)) return true;

    return false;
  }

  static int getInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return value;
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

  static Alignment getAlignmentGeometry(String alignment) {
    switch (alignment) {
      case "left":
        return Alignment.centerLeft;
      case "right":
        return Alignment.centerRight;
      case "center":
        return Alignment.center;
      // case "topLeft":
      //   return Alignment.topLeft;
      // case "topRight":
      //   return Alignment.topRight;
      case "top":
        return Alignment.topCenter;
      // case "bottomLeft":
      //   return Alignment.bottomLeft;
      // case "bottomRight":
      //   return Alignment.bottomRight;
      case "bottom":
        return Alignment.bottomCenter;
      default:
        return Alignment.center;
    }
  }

  static MainAxisAlignment getMainAxisAlignment(String position) {
    switch (position) {
      case "center":
        return MainAxisAlignment.center;
      case "start":
        return MainAxisAlignment.start;
      case "end":
        return MainAxisAlignment.end;
      case "spaceAround":
        return MainAxisAlignment.spaceAround;
      case "spaceBetween":
        return MainAxisAlignment.spaceBetween;
      case "spaceEvenly":
        return MainAxisAlignment.spaceEvenly;
      default:
        return MainAxisAlignment.center;
    }
  }

  static String getWidgetId(String type, String id) {
    if (type == null || type.isEmpty) type = '';
    if (id == null || id.isEmpty) id = '';
    String newId = id;

    if (newId.isEmpty) {
      newId = id.isNotEmpty ? id : type + Random().nextInt(100).toString();
      while (SmeupWidgetNotificationService.objects.firstWhere(
              (element) => element['id'] == newId,
              orElse: () => null) !=
          null) {
        newId = id.isNotEmpty
            ? id + Random().nextInt(100).toString()
            : type + Random().nextInt(100).toString();
      }
    }

    return newId;
  }
}
