import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

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
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {}
}
