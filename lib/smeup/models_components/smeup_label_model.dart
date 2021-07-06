import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLabelModel extends SmeupComponentModel
    implements SmeupDataInterface {
  static const double defaultPadding = 5.0;
  static const double defaultFontSize = 16.0;
  static const double defaultIconSize = 16.0;
  static const Alignment defaultAlign = Alignment.center;
  static const bool defaultFontbold = false;
  static const double defaultWidth = 0;
  static const double defaultHeight = 40;

  double padding;
  double fontSize;
  double iconSize;
  Alignment align;
  bool fontbold;
  double width;
  double height;
  dynamic clientData;
  String valueColName;
  String colorColName;
  String colorFontColName;
  int iconData;
  String iconColname;
  Color backColor;
  Color fontColor;

  SmeupLabelModel(
      {this.valueColName = '',
      this.padding = defaultPadding,
      this.fontSize = defaultFontSize,
      this.align = defaultAlign,
      this.fontbold = defaultFontbold,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.clientData,
      this.colorColName = '',
      this.backColor,
      this.fontColor,
      this.iconData = 0,
      this.iconColname = '',
      this.colorFontColName = '',
      this.iconSize = defaultIconSize,
      title = ''})
      : super(title: title) {
    //if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (fontColor == null)
      fontColor = SmeupOptions.theme.textTheme.bodyText1.color;
    id = 'LAB' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupLabelModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    valueColName = optionsDefault['valueColName'] ?? '';
    colorColName = optionsDefault['colorColName'] ?? '';
    colorFontColName = optionsDefault['colorFontColName'] ?? '';
    padding = getDouble(optionsDefault['padding']) ?? defaultPadding;
    fontSize = getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    iconSize = getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    align = getAlignmentGeometry(optionsDefault['align']);
    width = getDouble(optionsDefault['width']) ?? defaultWidth;
    height = getDouble(optionsDefault['height']) ?? defaultHeight;
    title = jsonMap['title'] ?? '';
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }
    if (optionsDefault['icon'] != null)
      iconData = int.tryParse(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    iconColname = optionsDefault['iconColName'] ?? '';
    if (optionsDefault['fontBold'] == null) {
      fontbold = defaultFontbold;
    } else {
      if (optionsDefault['fontBold'] is bool)
        fontbold = optionsDefault['fontBold'];
      else if (optionsDefault['fontBold'] == 'Yes')
        fontbold = true;
      else
        fontbold = false;
    }
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      var newList = List.empty(growable: true);
      (smeupServiceResponse.result.data['rows'] as List).forEach((element) {
        var newEl = {
          "value": element[optionsDefault['valueColName']],
          optionsDefault['iconColName']: element[optionsDefault['iconColName']],
          if (colorColName != null && colorColName.isNotEmpty)
            optionsDefault['colorColName']: SmeupUtilities.getColorFromRGB(
                element[optionsDefault['colorColName']]),
          if (colorFontColName != null && colorFontColName.isNotEmpty)
            optionsDefault['colorFontColName']: SmeupUtilities.getColorFromRGB(
                element[optionsDefault['colorFontColName']]),
          //"backColor": element[optionsDefault['colorColName']]
        };
        newList.add(newEl);
      });

      data = newList;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
