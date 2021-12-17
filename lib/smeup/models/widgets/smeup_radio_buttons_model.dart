import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_radio_buttons_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupRadioButtonsModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultRadioButtonColor;
  static double defaultFontSize;
  static Color defaultFontColor;
  static Color defaultBackColor;
  static bool defaultFontBold;
  static bool defaultCaptionFontBold;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static Color defaultCaptionBackColor;

  // unsupported by json_theme
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultWidth = 100;
  static const double defaultHeight = 75;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const int defaultColumns = 1;

  Color radioButtonColor;
  Color fontColor;
  double fontSize;
  Color backColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;

  double width;
  double height;
  Alignment align;
  EdgeInsetsGeometry padding;
  String valueField;
  String displayedField;
  String selectedValue;
  int columns;

  SmeupRadioButtonsModel(
      {GlobalKey<FormState> formKey,
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
      this.columns = defaultColumns})
      : super(formKey, title: title, id: id, type: type) {
    setDefaults(this);

    if (optionsDefault['type'] == null) optionsDefault['type'] = 'rad';

    SmeupDataService.incrementDataFetch(id);
  }

  SmeupRadioButtonsModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    displayedField = optionsDefault['displayedField'] ?? defaultDisplayedField;
    selectedValue = _replaceSelectedValue(jsonMap) ?? '';

    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;

    columns = SmeupUtilities.getInt(optionsDefault['radCol']) ?? defaultColumns;

    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;

    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;

    radioButtonColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['radioButtonColor']) ??
            defaultRadioButtonColor;

    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupRadioButtonsDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  _replaceSelectedValue(dynamic jsonMap) {
    if (optionsDefault['selectedValue'] != null) {
      return SmeupDynamismService.replaceFunVariables(
          optionsDefault['selectedValue'], formKey);
    }
  }

  static setDefaults(dynamic obj) {
    var radioTheme = SmeupConfigurationService.getTheme().radioTheme;

    defaultRadioButtonColor =
        radioTheme.fillColor.resolve(Set<MaterialState>());

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    var textStyle = SmeupConfigurationService.getTheme().textTheme.bodyText1;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    if (obj.radioButtonColor == null)
      obj.radioButtonColor = SmeupRadioButtonsModel.defaultRadioButtonColor;

    if (obj.fontColor == null)
      obj.fontColor = SmeupRadioButtonsModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupRadioButtonsModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = SmeupRadioButtonsModel.defaultBackColor;
    if (obj.fontBold == null)
      obj.fontBold = SmeupRadioButtonsModel.defaultFontBold;

    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupRadioButtonsModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupRadioButtonsModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupRadioButtonsModel.defaultCaptionBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupRadioButtonsModel.defaultCaptionFontBold;
  }
}
