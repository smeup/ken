import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_configuration_service.dart';

class KenTextAutocompleteModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize;
  static Color? defaultBackColor;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = 300;
  static const double defaultHeight = 55;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const bool defaultUnderline = true;
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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'acp';
    setDefaults(this);
  }

  KenTextAutocompleteModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack, null) {
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
        await this.getData(instanceCallBack);
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
    if (obj.borderColor == null)
      obj.borderColor = KenTextAutocompleteModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenTextAutocompleteModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenTextAutocompleteModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = KenTextAutocompleteModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = KenTextAutocompleteModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = KenTextAutocompleteModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = KenTextAutocompleteModel.defaultBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = KenTextAutocompleteModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenTextAutocompleteModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenTextAutocompleteModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = KenTextAutocompleteModel.defaultCaptionBackColor;
  }
}
