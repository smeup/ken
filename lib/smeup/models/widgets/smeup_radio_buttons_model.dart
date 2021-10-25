import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_radio_buttons_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupRadioButtonsModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 100;
  static const double defaultHeight = 50;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultFontsize = 16.0;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const String defaultValueField = 'code';
  static const String defaultDisplayedField = 'value';
  static const int defaultColumns = 1;

  Color backColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontsize;
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
      this.backColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.position = defaultPosition,
      this.align = defaultAlign,
      this.fontColor,
      this.fontsize = defaultFontsize,
      this.padding = defaultPadding,
      this.valueField = defaultValueField,
      this.displayedField = defaultDisplayedField,
      this.selectedValue,
      this.columns = defaultColumns})
      : super(formKey, title: title, id: id, type: type) {
    if (backColor == null) backColor = getDefaultBackColor();
    if (fontColor == null) fontColor = getDefaultFontColor();

    if (optionsDefault['type'] == null) optionsDefault['type'] = 'rad';

    SmeupDataService.incrementDataFetch(id);
  }

  static Color getDefaultBackColor() {
    return SmeupConfigurationService.getTheme().canvasColor;
  }

  static Color getDefaultFontColor() {
    return SmeupConfigurationService.getTheme().textTheme.bodyText1.color;
  }

  SmeupRadioButtonsModel.clone(SmeupRadioButtonsModel other)
      : this(
            title: other.title,
            backColor: other.backColor,
            width: other.width,
            height: other.height,
            position: other.position,
            align: other.align,
            fontColor: other.fontColor,
            fontsize: other.fontsize,
            padding: other.padding,
            valueField: other.valueField,
            displayedField: other.displayedField);

  SmeupRadioButtonsModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    displayedField = optionsDefault['displayedField'] ?? defaultDisplayedField;
    selectedValue = _replaceSelectedValue(jsonMap) ?? '';

    position = SmeupUtilities.getMainAxisAlignment(optionsDefault['position']);

    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;

    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;

    columns = SmeupUtilities.getInt(optionsDefault['radCol']) ?? defaultColumns;

    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
          getDefaultBackColor();
    } else {
      backColor = getDefaultBackColor();
    }

    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
          getDefaultFontColor();
    } else {
      fontColor = getDefaultFontColor();
    }

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
}
