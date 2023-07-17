// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../../services/ken_configuration_service.dart';

class KenRadioButtonsModel extends KenInputFieldModel
    implements KenDataInterface {
  // supported by json_theme
  static Color? defaultRadioButtonColor;
  static double? defaultFontSize = 14;
  static Color? defaultFontColor;
  static Color? defaultBackColor = Colors.transparent;
  static bool? defaultFontBold;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor;

  // unsupported by json_theme
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultWidth = 120;
  static const double defaultHeight = 150;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
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

  KenRadioButtonsModel(
      {GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      id,
      type,
      title = '',
      this.radioButtonColor,
      this.fontColor,
      this.fontSize,
      this.backColor,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.align = defaultAlign,
      this.padding = defaultPadding,
      this.valueField = defaultValueField,
      this.displayedField = defaultDisplayedField,
      this.selectedValue,
      this.columns = defaultColumns,
    })
      : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type) {
    setDefaults(this);

    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'rad';
  }

  KenRadioButtonsModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, parent) {
    setDefaults(this);

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

  // _replaceSelectedValue(dynamic jsonMap) {
  //   if (optionsDefault!['selectedValue'] != null) {
  //     return SmeupDynamismService.replaceVariables(
  //         optionsDefault!['selectedValue'], formKey);
  //   }
  // }

  static setDefaults(dynamic obj) {
    var radioTheme = KenConfigurationService.getTheme()!.radioTheme;

    defaultRadioButtonColor = radioTheme.fillColor!.resolve(<MaterialState>{});

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    var textStyle = KenConfigurationService.getTheme()!.textTheme.bodyText1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    obj.radioButtonColor ??= KenRadioButtonsModel.defaultRadioButtonColor;

    obj.fontColor ??= KenRadioButtonsModel.defaultFontColor;
    obj.fontSize ??= KenRadioButtonsModel.defaultFontSize;
    obj.backColor ??= KenRadioButtonsModel.defaultBackColor;
    obj.fontBold ??= KenRadioButtonsModel.defaultFontBold;

    obj.captionFontColor ??= KenRadioButtonsModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenRadioButtonsModel.defaultCaptionFontSize;
    obj.captionBackColor ??= KenRadioButtonsModel.defaultCaptionBackColor;
    obj.captionFontBold ??= KenRadioButtonsModel.defaultCaptionFontBold;
  }
}
