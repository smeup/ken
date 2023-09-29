// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenTextPasswordModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = Colors.transparent;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 2.0;
  static const double defaultBorderRadius = 8;
  static const Color defaultButtonBackColor = Colors.transparent;
  static const double defaultIconSize = 20;
  static const Color defaultIconColor = KenModel.kPrimary;

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
    this.backColor = defaultBackColor,
    this.fontSize = defaultFontSize,
    this.fontBold = defaultFontBold,
    this.fontColor = defaultFontColor,
    this.captionBackColor = defaultCaptionBackColor,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontColor = defaultCaptionFontColor,
    this.captionFontSize = defaultCaptionFontSize,
    this.borderColor = defaultBorderColor,
    this.borderRadius = defaultBorderRadius,
    this.borderWidth = defaultBorderWidth,
    this.iconSize = defaultIconSize,
    this.iconColor = defaultIconColor,
    this.buttonBackColor = defaultButtonBackColor,
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
    this.valueField = defaultValueField,
    this.showRules = defaultShowRules,
    this.checkRules = defaultCheckRules,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    backColor ??= KenConfigurationService.getTheme()!.backgroundColor;
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pwd';
    id = KenUtilities.getWidgetId('FLD', id);
  }

  KenTextPasswordModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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
        await getData();
      };
    }
  }
}
