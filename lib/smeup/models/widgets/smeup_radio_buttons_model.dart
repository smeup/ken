import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_radio_buttons_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupRadioButtonsModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 50;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultFontsize = 16.0;
  static const double defaultPadding = 10.0;
  static const String defaultValueField = 'k';
  static const String defaultDisplayedField = 'value';

  Color backColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontsize;
  double padding;
  double rightPadding;
  double leftPadding;
  double topPadding;
  double bottomPadding;
  String valueField;
  String displayedField;
  String selectedValue;

  SmeupRadioButtonsModel(
      {id,
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
      this.leftPadding = defaultPadding,
      this.rightPadding = defaultPadding,
      this.topPadding = defaultPadding,
      this.bottomPadding = defaultPadding,
      this.valueField = defaultValueField,
      this.displayedField = defaultDisplayedField,
      this.selectedValue})
      : super(title: title, id: id, type: type) {
    if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (fontColor == null)
      fontColor = SmeupOptions.theme.textTheme.bodyText1.color;

    if (optionsDefault['type'] == null) optionsDefault['type'] = 'rad';

    SmeupDataService.incrementDataFetch(id);
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
            leftPadding: other.leftPadding,
            rightPadding: other.rightPadding,
            topPadding: other.topPadding,
            bottomPadding: other.bottomPadding,
            valueField: other.valueField,
            displayedField: other.displayedField);

  SmeupRadioButtonsModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    rightPadding = SmeupUtilities.getDouble(optionsDefault['rightPadding']) ??
        defaultPadding;
    leftPadding = SmeupUtilities.getDouble(optionsDefault['leftPadding']) ??
        defaultPadding;
    topPadding = SmeupUtilities.getDouble(optionsDefault['topPadding']) ??
        defaultPadding;
    bottomPadding = SmeupUtilities.getDouble(optionsDefault['bottomPadding']) ??
        defaultPadding;

    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    displayedField = optionsDefault['displayedField'] ?? defaultDisplayedField;
    selectedValue = _replaceSelectedValue(jsonMap) ?? '';

    position = SmeupUtilities.getMainAxisAlignment(optionsDefault['position']);

    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']);

    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;

    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }

    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }

    if (widgetLoadType != LoadType.Delay) {
      SmeupRadioButtonsDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }

  _replaceSelectedValue(dynamic jsonMap) {
    if (optionsDefault['selectedValue'] != null) {
      return SmeupDynamismService.replaceFunVariables(
          optionsDefault['selectedValue']);
    }
  }
}
