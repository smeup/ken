import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_configuration_service.dart';

class KenTextPasswordModel extends KenModel implements KenDataInterface {
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
  static Color? defaultButtonBackColor;
  static double? defaultIconSize;
  static Color? defaultIconColor;

  // unsupported by json_theme

  static const String defaultLabel = '';
  static const String defaultSubmitLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultUnderline = true;
  static const bool defaultShowRules = true;
  static const bool defaultShowRulesIcon = true;
  static const bool defaultCheckRules = true;

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
  double? iconSize;
  Color? iconColor;
  Color? buttonBackColor;

  String? label;
  String? submitLabel;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  bool? underline;
  bool? autoFocus;
  String? valueField;
  bool? showSubmit;
  bool? showRules;
  bool? showRulesIcon;
  bool? checkRules;

  KenTextPasswordModel({
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
    this.iconSize,
    this.iconColor,
    this.buttonBackColor,
    this.label = defaultLabel,
    this.submitLabel = defaultSubmitLabel,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    this.showBorder = defaultShowBorder,
    this.showSubmit = defaultShowSubmit,
    this.showRulesIcon = defaultShowRulesIcon,
    title = '',
    this.underline = defaultUnderline,
    this.autoFocus = defaultAutoFocus,
    this.valueField,
    this.showRules = defaultShowRules,
    this.checkRules = defaultCheckRules,
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (backColor == null)
      backColor = KenConfigurationService.getTheme()!.backgroundColor;
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pwd';
    id = KenUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  KenTextPasswordModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
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
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;
    buttonBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['buttonBackColor']) ??
            defaultBackColor;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    underline = optionsDefault!['showUnderline'] ?? true;
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

    showRules =
        KenUtilities.getBool(optionsDefault!['showRules']) ?? defaultShowRules;

    showRulesIcon = KenUtilities.getBool(optionsDefault!['showRulesIcon']) ??
        defaultShowRulesIcon;

    checkRules = KenUtilities.getBool(optionsDefault!['checkRules']) ??
        defaultCheckRules;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupTextPasswordDao.getData(this);
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

    var iconTheme = KenConfigurationService.getTheme()!.iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    defaultButtonBackColor = KenConfigurationService.getTheme()!.primaryColor;

    // ----------------- set properties from default
    if (obj.borderColor == null)
      obj.borderColor = KenTextPasswordModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenTextPasswordModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenTextPasswordModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = KenTextPasswordModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = KenTextPasswordModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = KenTextPasswordModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = KenTextPasswordModel.defaultBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = KenTextPasswordModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenTextPasswordModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenTextPasswordModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = KenTextPasswordModel.defaultCaptionBackColor;
    if (obj.iconSize == null)
      obj.iconSize = KenTextPasswordModel.defaultIconSize;
    if (obj.iconColor == null)
      obj.iconColor = KenTextPasswordModel.defaultIconColor;
    if (obj.buttonBackColor == null)
      obj.buttonBackColor = KenTextPasswordModel.defaultButtonBackColor;
  }
}
