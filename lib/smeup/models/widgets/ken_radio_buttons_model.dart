// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenRadioButtonsModel extends KenInputFieldModel
    implements KenDataInterface {
  // supported by json_theme
  static const Color defaultRadioButtonColor = KenModel.kPrimary;
  static const double defaultFontSize = 14;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const Color defaultBackColor = Colors.transparent;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 16;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultWidth = 120;
  static const double defaultHeight = 150;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(16);
  static const int defaultColumns = 1;

  Color? radioButtonColor;
  Color? fontColor;
  double? fontSize;
  Color? backColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  double? width;
  double? height;
  Alignment? align;
  EdgeInsetsGeometry? padding;
  String? valueField;
  String? displayedField;
  String? selectedValue;
  int? columns;

  KenRadioButtonsModel({
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    id,
    type,
    title = '',
    this.radioButtonColor = defaultRadioButtonColor,
    this.fontColor = defaultFontColor,
    this.fontSize = defaultFontSize,
    this.backColor = defaultBackColor,
    this.fontBold = defaultFontBold,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultFontColor,
    this.captionBackColor = defaultCaptionBackColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.align = defaultAlign,
    this.padding = defaultPadding,
    this.valueField = defaultValueField,
    this.displayedField = defaultDisplayedField,
    this.selectedValue,
    this.columns = defaultColumns,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'rad';
  }

  KenRadioButtonsModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
    title = jsonMap['title'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    displayedField = optionsDefault!['displayedField'] ?? defaultDisplayedField;
    selectedValue = ''; //_replaceSelectedValue(jsonMap) ?? '';//todo

    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;

    columns = KenUtilities.getInt(optionsDefault!['radCol']) ?? defaultColumns;

    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

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

    radioButtonColor =
        KenUtilities.getColorFromRGB(optionsDefault!['radioButtonColor']) ??
            defaultRadioButtonColor;

    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupRadioButtonsDao.getData(this);
        await getData();
      };
    }
  }
}
