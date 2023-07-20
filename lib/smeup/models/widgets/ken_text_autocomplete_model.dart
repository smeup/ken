// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenTextAutocompleteModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize = 16;
  static Color? defaultBackColor = KenModel.kBlue200;
  static Color? defaultFontColor = KenModel.kGray100;
  static bool? defaultFontBold = false;
  static bool? defaultCaptionFontBold = false;
  static double? defaultCaptionFontSize = 16;
  static Color? defaultCaptionFontColor = KenModel.kGray100;
  static Color? defaultCaptionBackColor = Colors.transparent;
  static Color? defaultBorderColor = KenModel.kButtonBackgroundColor;
  static double? defaultBorderWidth = 0;
  static double? defaultBorderRadius = 10;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = double.maxFinite;
  static const double defaultHeight = 55;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const bool defaultUnderline = false;
  static const String defaultSubmitLabel = '';
  static const bool defaultShowSubmit = false;

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

  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  bool? showUnderline;
  bool? autoFocus;
  String? defaultValue;
  String? valueField;
  String? submitLabel;
  bool? showSubmit;

  KenTextAutocompleteModel({
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
    this.label = defaultLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    title = '',
    this.showUnderline = defaultUnderline,
    this.autoFocus = defaultAutoFocus,
    this.defaultValue = '',
    this.valueField = 'value',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'acp';
    setDefaults(this);
  }

  KenTextAutocompleteModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    showUnderline = optionsDefault!['showUnderline'] ?? true;
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

    defaultValue = jsonMap['defaultValue'] ?? '';
    valueField = optionsDefault!['valueField'] ?? 'value';
    showSubmit = optionsDefault!['showSubmit'] ?? defaultShowSubmit;
    submitLabel = optionsDefault!['submitLabel'] ?? defaultSubmitLabel;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupTextAutocompleteDao.getData(this);
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
    obj.borderColor ??= KenTextAutocompleteModel.defaultBorderColor;
    obj.borderWidth ??= KenTextAutocompleteModel.defaultBorderWidth;
    obj.borderRadius ??= KenTextAutocompleteModel.defaultBorderRadius;
    obj.fontBold ??= KenTextAutocompleteModel.defaultFontBold;
    obj.fontColor ??= KenTextAutocompleteModel.defaultFontColor;
    obj.fontSize ??= KenTextAutocompleteModel.defaultFontSize;
    obj.backColor ??= KenTextAutocompleteModel.defaultBackColor;
    obj.captionFontBold ??= KenTextAutocompleteModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenTextAutocompleteModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenTextAutocompleteModel.defaultCaptionFontSize;
    obj.captionBackColor ??= KenTextAutocompleteModel.defaultCaptionBackColor;
  }
}
