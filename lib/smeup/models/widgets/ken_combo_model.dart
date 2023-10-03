import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';

class KenComboModel extends KenInputFieldModel implements KenDataInterface {
  // supported by json_theme
  static const double defaultIconSize = 20;
  static const Color defaultIconColor = KenModel.kPrimary;
  static const double defaultFontSize = 16;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const bool defaultFontBold = false;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const Color defaultDropDownColor = KenModel.kBack100;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 8;
  static const String defaultTitle = 'title';
  static const double defaultWidth = 0;
  static const double defaultHeight = 55;
  static const String defaultValueField = 'value';
  static const String defaultDescriptionField = 'description';
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const String defaultLabel = '';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const bool defaultShowBorder = true;

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
  Color? dropdownColor;

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
      this.fontColor = defaultFontColor,
      this.fontSize = defaultFontSize,
      this.fontBold = defaultFontBold,
      this.backColor = defaultBackColor,
      this.captionFontBold = defaultCaptionFontBold,
      this.captionFontSize = defaultCaptionFontSize,
      this.captionFontColor = defaultCaptionFontColor,
      this.captionBackColor = defaultCaptionBackColor,
      this.borderColor = defaultBorderColor,
      this.borderRadius = defaultBorderRadius,
      this.dropdownColor = defaultDropDownColor,
      this.borderWidth = defaultBorderWidth,
      this.iconSize = defaultIconSize,
      this.iconColor = defaultIconColor,
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
  }

  KenComboModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    descriptionField =
        optionsDefault!['descriptionField'] ?? defaultDescriptionField;
    dropdownColor =
        KenUtilities.getColorFromRGB(optionsDefault!['dropDownColor']) ??
            defaultDropDownColor;
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
}
