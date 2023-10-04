// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenSpotLightModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = KenModel.kBack200;
  static const Color defaultFontColor = KenModel.kSecondary100;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 14;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = KenModel.kBack200;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 0;
  static const double defaultBorderRadius = 10;
  static const Color defaultIconColor = KenModel.kPrimary;
  static const double defaultIconSize = 10;
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
  Color? iconColor;
  double? iconSize;

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

  KenSpotLightModel({
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
    this.iconColor = defaultIconColor,
    this.iconSize = defaultIconSize,
    this.borderRadius = defaultBorderRadius,
    this.borderWidth = defaultBorderWidth,
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
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type);

  KenSpotLightModel.fromMap(
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

    label = optionsDefault!['watermark'] ?? defaultLabel;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    showUnderline = optionsDefault!['showUnderline'] ?? defaultUnderline;
    autoFocus = optionsDefault!['autoFocus'] ?? defaultAutoFocus;

    showBorder = KenUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;

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
}
