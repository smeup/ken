// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';

class KenComboModel extends KenInputFieldModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultIconSize;
  static Color? defaultIconColor;
  static double? defaultFontSize;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static Color? defaultBackColor;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor = Colors.transparent;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius = 4;

  // unsupported by json_theme
  static const double defaultWidth = 100;
  static const double defaultHeight = 55;
  static const String defaultValueField = 'value';
  static const String defaultDescriptionField = 'description';
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const String defaultLabel = '';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultInnerSpace = 0.0;
  static const bool defaultUnderline = false;
  static const bool defaultShowBorder = false;

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  Color? backColor;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  double? iconSize;
  Color? iconColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;

  bool? underline;
  double? width;
  double? height;
  double? innerSpace;
  Alignment? align;
  String? valueField;
  String? descriptionField;
  String? selectedValue;
  String? label;
  EdgeInsetsGeometry? padding;
  bool? showBorder;

  KenComboModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.fontColor,
      this.fontSize,
      this.fontBold,
      this.backColor,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.iconSize,
      this.iconColor,
      this.underline = defaultUnderline,
      this.align = defaultAlign,
      this.innerSpace = defaultInnerSpace,
      this.valueField = defaultValueField,
      this.descriptionField = defaultDescriptionField,
      this.padding = defaultPadding,
      this.selectedValue = '',
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.showBorder = defaultShowBorder,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'cmb';
    setDefaults(this);
  }

  KenComboModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    descriptionField =
        optionsDefault!['descriptionField'] ?? defaultDescriptionField;
    selectedValue = optionsDefault!['defaultValue'] ?? '';
    label = optionsDefault!['label'] ?? defaultLabel;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;

    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault!['bold'] ?? defaultFontBold;
    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    underline =
        KenUtilities.getBool(optionsDefault!['underline']) ?? defaultUnderline;

    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;
    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;
    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;
    captionBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
            defaultCaptionBackColor;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    showBorder = KenUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupComboDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
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
    defaultIconColor = textStyle.color;

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
    //iconTheme.color;

    // ----------------- set properties from default
    obj.borderColor ??= KenComboModel.defaultBorderColor;
    obj.borderWidth ??= KenComboModel.defaultBorderWidth;
    obj.borderRadius ??= KenComboModel.defaultBorderRadius;

    obj.fontBold ??= KenComboModel.defaultFontBold;
    obj.fontColor ??= KenComboModel.defaultFontColor;
    obj.fontSize ??= KenComboModel.defaultFontSize;
    obj.backColor ??= KenComboModel.defaultBackColor;

    obj.captionFontBold ??= KenComboModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenComboModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenComboModel.defaultCaptionFontSize;
    obj.captionBackColor ??= KenComboModel.defaultCaptionBackColor;

    obj.iconSize ??= KenComboModel.defaultIconSize;
    obj.iconColor ??= KenComboModel.defaultIconColor;
  }
}
