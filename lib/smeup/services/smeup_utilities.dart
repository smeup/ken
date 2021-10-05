import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';

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

  // TODO it should return null if the color string is not parsable
  static Color getColorFromRGB(String color, {double opacity = 1.0}) {
    final split = color.split(RegExp(r"(?=[A-Z])"));
    if (split == null || split.length != 3)
      return SmeupConfigurationService.getTheme().textTheme.headline6.color;

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

  static EdgeInsetsGeometry getPadding(dynamic value) {
    if (value == null)
      return EdgeInsets.all(0);
    else if (value is double) {
      return EdgeInsets.all(SmeupUtilities.getDouble(value));
    } else if (value is int) {
      return EdgeInsets.all(SmeupUtilities.getDouble(value));
    } else if (value is String) {
      return EdgeInsets.all(SmeupUtilities.getDouble(value));
    } else {
      double left = 0;
      double right = 0;
      double top = 0;
      double bottom = 0;
      if (value['left'] != null) left = SmeupUtilities.getDouble(value['left']);
      if (value['right'] != null)
        right = SmeupUtilities.getDouble(value['right']);
      if (value['top'] != null) top = SmeupUtilities.getDouble(value['top']);
      if (value['bottom'] != null)
        bottom = SmeupUtilities.getDouble(value['bottom']);
      return EdgeInsets.only(
          top: top, bottom: bottom, left: left, right: right);
    }
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

  static TextInputType getKeyboard(String keyboard) {
    switch (keyboard) {
      case "datetime":
        return TextInputType.datetime;
      case "emailAddress":
        return TextInputType.emailAddress;
      case "multiline":
        return TextInputType.multiline;
      case "name":
        return TextInputType.name;
      case "number":
        return TextInputType.number;
      case "phone":
        return TextInputType.phone;
      case "streetAddress":
        return TextInputType.streetAddress;
      case "text":
        return TextInputType.text;
      case "url":
        return TextInputType.url;
      case "visiblePassword":
        return TextInputType.visiblePassword;
      default:
        return TextInputType.text;
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

  static String replaceDictionaryPlaceHolders(String source) {
    String workString = source;
    if (SmeupConfigurationService.appDictionary != null) {
      RegExp re = RegExp(r'\{\{.*\}\}');
      re.allMatches(source).forEach((match) {
        final placeHolder = source.substring(match.start, match.end);
        if (placeHolder != null && placeHolder.isNotEmpty) {
          final dictionaryKey =
              placeHolder.replaceFirst('{{', '').replaceFirst('}}', '');

          if (dictionaryKey != null &&
              SmeupConfigurationService.appDictionary
                      .getLocalString(dictionaryKey) !=
                  null) {
            workString = workString.replaceAll(
                placeHolder,
                SmeupConfigurationService.appDictionary
                    .getLocalString(dictionaryKey));
          }
        }
      });
    }

    return workString;
  }
}
