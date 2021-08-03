import 'dart:math';

import 'package:flutter/material.dart';
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
  String clientData;
  String valueField;
  String displayedField;
  String selectedValue;

  SmeupRadioButtonsModel(
      {title = '',
      this.clientData = '',
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
      : super(title: title) {
    if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (fontColor == null)
      fontColor = SmeupOptions.theme.textTheme.bodyText1.color;
    id = 'FLD' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

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
    SmeupDataService.incrementDataFetch(id);
  }

  _replaceSelectedValue(dynamic jsonMap) {
    if (optionsDefault['selectedValue'] != null) {
      return SmeupDynamismService.replaceFunVariables(
          optionsDefault['selectedValue']);
    }
  }

  @override
  // ignore: override_on_non_overriding_member
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      data = smeupServiceResponse.result.data;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
