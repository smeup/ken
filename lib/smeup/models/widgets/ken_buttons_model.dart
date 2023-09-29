// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenButtonsModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultBackColor = KenModel.kPrimary;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 5;
  static const double defaultElevation = 0;
  static const double defaultFontSize = 14;
  static const Color defaultFontColor = Colors.white;
  static const bool defaultFontBold = false;
  static const double defaultIconSize = 16;
  static const Color defaultIconColor = Colors.white;

  // unsupported by json_theme
  static const double defaultWidth = 180;
  static const double defaultHeight = 50;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.centerRight;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const String defaultValueField = 'value';
  static const double defaultInnerSpace = 10.0;
  static const bool defaultIsLink = false;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.Vertical;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? iconSize;
  Color? iconColor;

  MainAxisAlignment? position;
  Alignment? align;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? valueField;
  dynamic iconCode;
  WidgetOrientation? orientation;
  bool? isLink;
  double? innerSpace;

  KenButtonsModel({
    id,
    type,
    title = '',
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.backColor = defaultBackColor,
    this.borderColor = defaultBorderColor,
    this.borderWidth = defaultBorderWidth,
    this.borderRadius = defaultBorderRadius,
    this.elevation = defaultElevation,
    this.fontSize = defaultFontSize,
    this.fontColor = defaultFontColor,
    this.fontBold = defaultFontBold,
    this.iconSize = defaultFontSize,
    this.iconColor = defaultIconColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.position = defaultPosition,
    this.align = defaultAlign,
    this.padding = defaultPadding,
    this.valueField = defaultValueField,
    this.iconCode,
    this.orientation = defaultOrientation,
    this.isLink = defaultIsLink,
    this.innerSpace = defaultInnerSpace,
  }) : super(formKey, scaffoldKey, context, title: title, id: id) {
    // SmeupDataService.incrementDataFetch(id);
  }

  KenButtonsModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    title = jsonMap['title'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    if (KenUtilities.getBool(optionsDefault!['fillSpace']) ?? false) {
      width = 0;
    }
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;

    if (KenUtilities.getBool(optionsDefault!['horiz']) ?? false) {
      orientation = WidgetOrientation.Horizontal;
    } else {
      orientation = defaultOrientation;
    }

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    position = KenUtilities.getMainAxisAlignment(optionsDefault!['position']);
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    if (optionsDefault!['icon'] != null) iconCode = optionsDefault!['icon'];
    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;
    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    elevation = KenUtilities.getDouble(optionsDefault!['elevation']) ??
        defaultElevation;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    isLink = KenUtilities.getBool(optionsDefault!['flat']) ?? defaultIsLink;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await getData();
        // await SmeupButtonsDao.getData(this);
      };
    }
    // SmeupDataService.incrementDataFetch(id);
  }
}
