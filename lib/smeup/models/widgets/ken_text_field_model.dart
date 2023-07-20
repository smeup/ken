// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenTextFieldModel extends KenInputFieldModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize = 16;
  static Color? defaultBackColor = Colors.transparent;
  static Color? defaultFontColor = KenModel.kButtonBackgroundColor;
  static bool? defaultFontBold = false;
  static bool? defaultCaptionFontBold = false;
  static double? defaultCaptionFontSize = 14;
  static Color? defaultCaptionFontColor = KenModel.kButtonBackgroundColor;
  static Color? defaultCaptionBackColor = Colors.transparent;
  static Color? defaultBorderColor = KenModel.kButtonBackgroundColor;
  static double? defaultBorderWidth = 2;
  static double? defaultBorderRadius = 8;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const String defaultSubmitLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = double.maxFinite;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultUnderline = false;

  Color? backColor;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;

  bool? underline;
  String? label;
  String? submitLabel;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  bool? autoFocus;
  String? valueField;
  bool? showSubmit;
  TextInputType? keyboard;

  KenTextFieldModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.backColor,
    this.fontSize,
    this.fontBold,
    this.fontColor,
    this.captionBackColor,
    this.captionFontBold,
    this.captionFontColor,
    this.captionFontSize,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.underline = defaultUnderline,
    this.label = defaultLabel,
    this.submitLabel = defaultSubmitLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    this.showSubmit = defaultShowSubmit,
    title = '',
    this.autoFocus = defaultAutoFocus,
    this.valueField,
    this.keyboard,
  }) : super(
          formKey,
          scaffoldKey,
          context,
          title: title,
          id: id,
          type: type,
        ) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'itx';
    id = KenUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  KenTextFieldModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    KenModel parent,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
    setDefaults(this);

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
    submitLabel = optionsDefault!['submitLabel'] ?? defaultSubmitLabel;
    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    showSubmit = optionsDefault!['showSubmit'] ?? defaultShowSubmit;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    underline = optionsDefault!['showUnderline'] ?? defaultUnderline;
    autoFocus = optionsDefault!['autoFocus'] ?? false;

    showBorder = KenUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    keyboard = KenUtilities.getKeyboard(optionsDefault!['keyboard']);

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupTextFieldDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var timePickerTheme = KenConfigurationService.getTheme()!.timePickerTheme;
    defaultBackColor = timePickerTheme.backgroundColor;
    var shape = timePickerTheme.shape!;
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;
    var side = timePickerTheme.dayPeriodBorderSide!;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var textStyle = KenConfigurationService.getTheme()!.textTheme.bodyText1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = textStyle.backgroundColor;

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default
    obj.borderColor ??= KenTextFieldModel.defaultBorderColor;
    obj.borderWidth ??= KenTextFieldModel.defaultBorderWidth;
    obj.borderRadius ??= KenTextFieldModel.defaultBorderRadius;
    obj.fontBold ??= KenTextFieldModel.defaultFontBold;
    obj.fontColor ??= KenTextFieldModel.defaultFontColor;
    obj.fontSize ??= KenTextFieldModel.defaultFontSize;
    obj.backColor ??= KenTextFieldModel.defaultBackColor;
    obj.captionFontBold ??= KenTextFieldModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenTextFieldModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenTextFieldModel.defaultCaptionFontSize;
    obj.captionBackColor ??= KenTextFieldModel.defaultCaptionBackColor;
  }
}
