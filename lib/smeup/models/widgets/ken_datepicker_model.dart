// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

import '../../services/ken_configuration_service.dart';

class KenDatePickerModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 1;
  static const double defaultBorderRadius = 4.0;
  static const bool defaultFontBold = false;
  static const double defaultFontSize = 16;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const double defaultElevation = 0;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const bool defaultShowBorder = false;
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const Color defaultDashColor = KenModel.kBack100;

  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  bool? fontBold;
  double? fontSize;
  Color? fontColor;
  Color? backColor;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  double? elevation;
  bool? underline;
  double? innerSpace;
  Alignment? align;
  String? valueField;
  String? displayedField;
  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  Color? dashColor;

  List<String>? minutesList;

  KenDatePickerModel({
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    id,
    type,
    this.borderColor = defaultBorderColor,
    this.borderWidth = defaultBorderWidth,
    this.borderRadius = defaultBorderRadius,
    this.fontBold = defaultFontBold,
    this.fontSize = defaultFontSize,
    this.fontColor = defaultFontColor,
    this.backColor = defaultBackColor,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultCaptionFontColor,
    this.captionBackColor = defaultCaptionBackColor,
    this.elevation = defaultElevation,
    this.underline = defaultUnderline,
    this.align = defaultAlign,
    this.valueField = defaultValueField,
    this.displayedField = defaultdisplayedField,
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    this.innerSpace = defaultInnerSpace,
    this.dashColor = defaultDashColor,
    title = '',
    this.minutesList,
  }) : super(formKey, scaffoldKey, context, id: id, type: type, title: title) {
    id = KenUtilities.getWidgetId('FLD', id);
  }

  KenDatePickerModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    displayedField = optionsDefault!['displayedField'] ?? defaultdisplayedField;
    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;
    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    captionBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    dashColor = KenUtilities.getColorFromRGB(optionsDefault!['dashColor']) ??
        defaultDashColor;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    label = optionsDefault!['label'] ?? defaultLabel;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    elevation = KenUtilities.getDouble(optionsDefault!['elevation']) ??
        defaultElevation;
    if (optionsDefault!['minutesList'] == null) {
      minutesList = null;
    } else {
      minutesList = (optionsDefault!['minutesList'] as List)
          .map((e) => e.toString())
          .toList();
    }
    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;
    showBorder = KenUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;

    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    underline =
        KenUtilities.getBool(optionsDefault!['underline']) ?? defaultUnderline;

    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await getData();
        // await SmeupDatePickerDao.getData(this);
      };
    }
  }
}
