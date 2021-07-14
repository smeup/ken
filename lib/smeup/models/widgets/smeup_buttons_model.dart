import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupButtonsModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 60;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultFontsize = 16.0;
  static const double defaultPadding = 0.0;
  static const double defaultBorderRadius = 10.0;
  static const double defaultElevation = 0.0;
  static const bool defaultBold = true;
  static const double defaultIconSize = 20.0;

  Color backColor;
  Color borderColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontsize;
  double padding;
  String clientData;
  String valueField;
  double borderRadius;
  double elevation;
  bool bold;
  double iconSize;
  int iconData;

  SmeupButtonsModel({
    title = '',
    this.clientData = '',
    this.backColor,
    this.borderColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.position = defaultPosition,
    this.align = defaultAlign,
    this.fontColor,
    this.fontsize = defaultFontsize,
    this.padding = defaultPadding,
    this.valueField,
    this.borderRadius = defaultBorderRadius,
    this.elevation = defaultElevation,
    this.bold = defaultBold,
    this.iconData = 0,
    this.iconSize = defaultIconSize,
  }) : super(title: title) {
    id = 'BTN' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupButtonsModel.clone(SmeupButtonsModel other)
      : this(
            title: other.title,
            clientData: other.clientData,
            backColor: other.backColor,
            borderColor: other.borderColor,
            width: other.width,
            height: other.height,
            position: other.position,
            align: other.align,
            fontColor: other.fontColor,
            fontsize: other.fontsize,
            padding: other.padding,
            valueField: other.valueField,
            borderRadius: other.borderRadius,
            elevation: other.elevation,
            bold: other.bold,
            iconData: other.iconData,
            iconSize: other.iconSize);

  SmeupButtonsModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    valueField = optionsDefault['valueField'] ?? '';
    position = SmeupUtilities.getMainAxisAlignment(optionsDefault['position']);
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    if (optionsDefault['icon'] != null)
      iconData = int.tryParse(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']);

    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;

    bold = optionsDefault['bold'] ?? true;

    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    if (optionsDefault['borderColor'] != null) {
      borderColor =
          SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']);
    }
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
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

      data = smeupServiceResponse.result.data['rows'];
      if ((data as List).length > 0) {
        if (valueField.isNotEmpty) {
          clientData = data[0][valueField];
        } else {
          clientData = (data[0] as Node).label;
        }
      }
    } else if (data != null) {
      clientData = data[0]['value'];
    }

    if (clientData == null) {
      SmeupLogService.writeDebugMessage('SmeupButtonsModel clientData is null',
          logType: LogType.error);
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
