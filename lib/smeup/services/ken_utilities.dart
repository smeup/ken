import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';

import '../models/ken_device_info.dart';
import 'ken_configuration_service.dart';
import 'ken_log_service.dart';
import 'ken_widget_notification_service.dart';

class KenUtilities {
  static Map _globalVariables = Map();
  static Map _formVariables = Map();

  static dynamic getEmptyDataStructure() {
    return {"messages": [], "columns": null, "rows": null, "type": ""};
  }

  static bool isDataStructure(dynamic data) {
    if (data == null) return false;
    if (data is List) return false;
    if (data['rows'] == null) {
      return false;
    }
    return true;
  }

  static setVariable(String? key, dynamic value,
      {GlobalKey<FormState>? formKey}) {
    var workKey = key;
    if (formKey == null) {
      _globalVariables[workKey] = value;

      if (_globalVariables[workKey] == null) {
        KenLogService.writeDebugMessage(
            "Added the global variable : $workKey, value: $value",
            logType: KenLogType.debug);
      } else {
        KenLogService.writeDebugMessage(
            "Changed the global variable : $workKey, value: $value",
            logType: KenLogType.debug);
      }
    } else {
      workKey = '${formKey.hashCode.toString()}_$key';

      _formVariables[workKey] = value;

      if (_formVariables[workKey] == null) {
        KenLogService.writeDebugMessage(
            "Added the form variable : $workKey, value: $value",
            logType: KenLogType.debug);
      } else {
        KenLogService.writeDebugMessage(
            "Changed the form variable : $workKey, value: $value",
            logType: KenLogType.debug);
      }
    }
  }

  static String replaceVariables(
      String funString, GlobalKey<FormState>? formKey) {
    KenUtilities.getVariables(formKey: formKey).entries.forEach((element) {
      String key = element.key;
      if (formKey != null)
        key = key.replaceAll('${formKey.hashCode.toString()}_', '');

      // to verify: old case where the user encloses the variable's name between quotation marks
      // if (element.value is String) {
      //   funString = funString.replaceAll('[$key]', element.value.toString());
      // } else {
      //   funString =
      //       funString.replaceAll('\"[$key]\"', element.value.toString());
      // }
      funString = funString.replaceAll('[$key]', element.value.toString());
    });
    try {
      // remove not replacable variable
      RegExp re = RegExp(r'\[[^\]]*\]');
      String newFun = funString;
      re.allMatches(funString).forEach((match) {
        final value = funString
            .substring(match.start, match.end)
            .replaceFirst('[', '')
            .replaceFirst(']', '');
        if (value.isNotEmpty) {
          newFun = newFun.replaceAll('[$value]', '');
          KenLogService.writeDebugMessage(
              'removed the parameter: $value in replaceFunVariables',
              logType: KenLogType.warning);
        }
      });
      funString = newFun;
    } catch (e) {
      KenLogService.writeDebugMessage(
          'Error in replaceFunVariables: $funString ',
          logType: KenLogType.error);
    }
    return funString;
  }

  static dynamic getVariable(String? key, {GlobalKey<FormState>? formKey}) {
    var value = _formVariables['${formKey.hashCode.toString()}_$key'];
    if (value == null) {
      value = _globalVariables[key];
    }
    return value;
  }

  static Map getVariables({GlobalKey<FormState>? formKey}) {
    return KenUtilities._getJoinMap(formKey: formKey);
  }

  static Map _getJoinMap({GlobalKey<FormState>? formKey}) {
    var join = Map();

    join.addEntries(_globalVariables.entries);

    if (formKey == null)
      join.addEntries(_formVariables.entries);
    else
      join.addEntries(_formVariables.entries.where((element) =>
          element.key.toString().startsWith(formKey.hashCode.toString())));

    return join;
  }

  static String? extractValueFromType(
      Map fields, String tipo, String parametro) {
    Map? retField;
    for (var i = 0; i < fields.entries.length; i++) {
      final element = fields.entries.elementAt(i);
      if (element.value['smeupObject']['tipo'] == tipo &&
          element.value['smeupObject']['parametro'] == parametro) {
        retField = fields[element.key];
        break;
      }
    }
    return extractValueFromName(retField!);
  }

  static String? extractValueFromName(Map field) {
    String? fieldValue;
    Map? smeupObject = field['smeupObject'];
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

  static Color? getColorFromRGB(String? color, {double opacity = 1.0}) {
    if (color == null) return null;

    final split = color.split(RegExp(r"(?=[A-Z])"));
    if (split.length != 3) return null;

    try {
      int r = int.parse(split[0].substring(1));
      int g = int.parse(split[1].substring(1));
      int b = int.parse(split[2].substring(1));

      return Color.fromRGBO(r, g, b, opacity);
    } catch (e) {
      KenLogService.writeDebugMessage(
          'Error in getColorFromRGB while extracting color: $color ',
          logType: KenLogType.error);
      return null;
    }
  }

  static bool isNumeric(String s) {
    if (((int.tryParse(s) ?? null) != null) ||
        ((double.tryParse(s) ?? null) != null)) return true;

    return false;
  }

  static int? getInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is double) {
      return value.toInt();
    } else if (value is String) {
      return int.tryParse(value);
    }
    return value;
  }

  static double? getDouble(dynamic value) {
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

  static EdgeInsetsGeometry? getPadding(dynamic value) {
    if (value == null)
      return null;
    else if (value is double) {
      return EdgeInsets.all(KenUtilities.getDouble(value)!);
    } else if (value is int) {
      return EdgeInsets.all(KenUtilities.getDouble(value)!);
    } else if (value is String) {
      return EdgeInsets.all(KenUtilities.getDouble(value)!);
    } else {
      double? left = 0;
      double? right = 0;
      double? top = 0;
      double? bottom = 0;
      if (value['left'] != null) left = KenUtilities.getDouble(value['left']);
      if (value['right'] != null)
        right = KenUtilities.getDouble(value['right']);
      if (value['top'] != null) top = KenUtilities.getDouble(value['top']);
      if (value['bottom'] != null)
        bottom = KenUtilities.getDouble(value['bottom']);
      return EdgeInsets.only(
          top: top!, bottom: bottom!, left: left!, right: right!);
    }
  }

  static Alignment? getAlignmentGeometry(String? alignment) {
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
        return null;
    }
  }

  static MainAxisAlignment getMainAxisAlignment(String? position) {
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

  static TextInputType getKeyboard(String? keyboard) {
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

  static String getWidgetId(String? type, String? id) {
    if (type == null || type.isEmpty) type = '';
    if (id == null || id.isEmpty) id = '';
    String newId = id;

    if (newId.isEmpty) {
      // SmeupLogService.writeDebugMessage('getWidgetId. type: $type',
      //     logType: LogType.debug);
      newId = id.isNotEmpty
          ? id
          : getRandom(type, ''); //type + Random().nextInt(10000).toString();
      while (KenWidgetNotificationService.objects.firstWhere(
              (element) => element['id'] == newId,
              orElse: () => null) !=
          null) {
        newId = getRandom(type, id);
      }
    }

    return newId;
  }

  static String getRandom(String type, String id) {
    String datetime = DateTime.now().toString();
    String newId = id.isNotEmpty
        ? id + datetime + Random().nextInt(100).toString()
        : type + datetime + Random().nextInt(100).toString();
    return newId.replaceAll(' ', '_');
  }

  static String replaceDictionaryPlaceHolders(String source) {
    String workString = source;
    if (KenConfigurationService.appDictionary != null) {
      RegExp re = RegExp(r'\{\{.*\}\}');
      re.allMatches(source).forEach((match) {
        final placeHolder = source.substring(match.start, match.end);
        if (placeHolder.isNotEmpty) {
          final dictionaryKey =
              placeHolder.replaceFirst('{{', '').replaceFirst('}}', '');

          if (KenConfigurationService.appDictionary
                  .getLocalString(dictionaryKey) !=
              null) {
            workString = workString.replaceAll(
                placeHolder,
                KenConfigurationService.appDictionary
                    .getLocalString(dictionaryKey));
          }
        }
      });
    }

    return workString;
  }

  static bool? getBool(dynamic value) {
    if (value is bool) {
      return value;
    } else if (value is String) {
      switch (value.toLowerCase()) {
        case 'yes':
        case 'si':
          return true;
        case 'no':
          return false;
      }
    }
    return null;
  }

  static void invokeScaffoldMessenger(BuildContext context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text), duration: Duration(milliseconds: 4000)));
  }

  static KenDeviceInfo getDeviceInfo() {
    var pixelRatio = window.devicePixelRatio;

    //Size in physical pixels
    var physicalScreenSize = window.physicalSize;
    var physicalWidth = physicalScreenSize.width;
    var physicalHeight = physicalScreenSize.height;

    //Size in logical pixels
    var logicalScreenSize = window.physicalSize / pixelRatio;
    var logicalWidth = logicalScreenSize.width;
    var logicalHeight = logicalScreenSize.height;

    //Padding in physical pixels
    var padding = window.padding;

    //Safe area paddings in logical pixels
    var paddingLeft = window.padding.left / window.devicePixelRatio;
    var paddingRight = window.padding.right / window.devicePixelRatio;
    var paddingTop = window.padding.top / window.devicePixelRatio;
    var paddingBottom = window.padding.bottom / window.devicePixelRatio;

    //Safe area in logical pixels
    var safeWidth = logicalWidth - paddingLeft - paddingRight;
    var safeHeight = logicalHeight - paddingTop - paddingBottom;

    var smeupDeviceInfo = KenDeviceInfo(
        padding, physicalHeight, physicalWidth, safeHeight, safeWidth);

    return smeupDeviceInfo;
  }
}
