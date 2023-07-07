import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_input_field_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_configuration_service.dart';

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
  static double? defaultBorderRadius;

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
      title = '',
      required Function(ServicesCallbackType type,
              Map<dynamic, dynamic>? jsonMap, KenModel? instance)
          instanceCallBack})
      : super(formKey, scaffoldKey, context,
            title: title,
            instanceCallBack: instanceCallBack,
            id: id,
            type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'cmb';
    setDefaults(this);
  }

  KenComboModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          instanceCallBack)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, parent, instanceCallBack) {
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
        await this.getData(instanceCallBack);
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
    if (obj.borderColor == null)
      obj.borderColor = KenComboModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenComboModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenComboModel.defaultBorderRadius;

    if (obj.fontBold == null) obj.fontBold = KenComboModel.defaultFontBold;
    if (obj.fontColor == null) obj.fontColor = KenComboModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = KenComboModel.defaultFontSize;
    if (obj.backColor == null) obj.backColor = KenComboModel.defaultBackColor;

    if (obj.captionFontBold == null)
      obj.captionFontBold = KenComboModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenComboModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenComboModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = KenComboModel.defaultCaptionBackColor;

    if (obj.iconSize == null) obj.iconSize = KenComboModel.defaultIconSize;
    if (obj.iconColor == null) obj.iconColor = KenComboModel.defaultIconColor;
  }
}
