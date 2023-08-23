// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

import '../../services/ken_configuration_service.dart';

class KenDatePickerModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBorderColor = KenModel.kButtonBackgroundColor;
  static double? defaultBorderWidth = 1;
  static double? defaultBorderRadius = 4.0;
  static bool? defaultFontBold = false;
  static double? defaultFontSize = 14;
  static Color? defaultFontColor = KenModel.kButtonBackgroundColor;
  static Color? defaultBackColor = Colors.transparent;
  static bool? defaultCaptionFontBold = false;
  static double? defaultCaptionFontSize = 10;
  static Color? defaultCaptionFontColor = KenModel.kButtonBackgroundColor;
  static Color? defaultCaptionBackColor;
  static double? defaultElevation = 0;

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

  List<String>? minutesList;

  KenDatePickerModel({
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    id,
    type,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontBold,
    this.fontSize,
    this.fontColor,
    this.backColor,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.elevation,
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
    title = '',
    this.minutesList,
  }) : super(formKey, scaffoldKey, context, id: id, type: type, title: title) {
    id = KenUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  KenDatePickerModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

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

  static setDefaults(dynamic obj) {
    // var timePickerTheme = KenConfigurationService.getTheme()!.timePickerTheme;
    // defaultBackColor = timePickerTheme.backgroundColor;
    // var shape = timePickerTheme.shape!;
    // defaultBorderRadius = (shape as ContinuousRectangleBorder)
    //     .borderRadius
    //     .resolve(TextDirection.ltr)
    //     .topLeft
    //     .x;
    // var side = timePickerTheme.dayPeriodBorderSide!;
    // defaultBorderColor = side.color;
    // defaultBorderWidth = side.width;

    // var buttonStyle =
    //     KenConfigurationService.getTheme()!.elevatedButtonTheme.style!;
    // defaultElevation = buttonStyle.elevation!.resolve(<MaterialState>{});

    // var textStyle = KenConfigurationService.getTheme()!.textTheme.bodyText1!;
    // defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    // defaultFontSize = textStyle.fontSize;
    // defaultFontColor = textStyle.color;

    // var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    // defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    // defaultCaptionFontSize = captionStyle.fontSize;
    // defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    obj.backColor ??= KenDatePickerModel.defaultBackColor;
    obj.elevation ??= KenDatePickerModel.defaultElevation;
    obj.borderColor ??= KenDatePickerModel.defaultBorderColor;
    obj.borderWidth ??= KenDatePickerModel.defaultBorderWidth;
    obj.borderRadius ??= KenDatePickerModel.defaultBorderRadius;
    obj.fontBold ??= KenDatePickerModel.defaultFontBold;
    obj.fontColor ??= KenDatePickerModel.defaultFontColor;
    obj.fontSize ??= KenDatePickerModel.defaultFontSize;
    obj.captionFontBold ??= KenDatePickerModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenDatePickerModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenDatePickerModel.defaultCaptionFontSize;
  }
}
