import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupInputFieldModel extends SmeupComponentModel
    implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const double defaultPadding = 0.0;
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;

  Color backColor;
  double fontsize;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  dynamic clientData;
  bool showUnderline;
  bool autoFocus;

  SmeupInputFieldModel(
      {this.backColor,
      this.fontsize = defaultFontsize,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      title = '',
      this.clientData,
      this.showUnderline = true,
      this.autoFocus = defaultAutoFocus,
      id})
      : super(title: title) {
    if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (id == null) id = 'FLD' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupInputFieldModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize = getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    label = optionsDefault['label'] ?? defaultLabel;
    padding = getDouble(optionsDefault['padding']) ?? defaultPadding;
    width = getDouble(optionsDefault['width']) ?? defaultWidth;
    height = getDouble(optionsDefault['height']) ?? defaultHeight;
    showUnderline = optionsDefault['showUnderline'] ?? true;
    autoFocus = optionsDefault['autoFocus'] ?? false;
    if (optionsDefault['showborder'] == null) {
      showborder = defaultShowBorder;
    } else {
      if (optionsDefault['showborder'] == 'Yes')
        showborder = true;
      else
        showborder = false;
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

      data = smeupServiceResponse.result.data;
    }

    if (clientData != null) {
      data = _getClientDataStructure(clientData);
    }
    SmeupDataService.decrementDataFetch(id);
  }

  SmeupInputFieldModel clone() {
    return SmeupInputFieldModel(
        backColor: backColor,
        fontsize: fontsize,
        label: label,
        width: width,
        height: height,
        padding: padding,
        showborder: showborder,
        clientData: clientData,
        showUnderline: showUnderline);
  }

  dynamic _getClientDataStructure(data) {
    if (optionsDefault == null) {
      return {
        "rows": [
          {
            'value': data,
          }
        ],
      };
    } else {
      switch (optionsDefault['type']) {
        case 'itx':
          return {
            "rows": [
              {
                'value': data,
              }
            ],
          };

          break;

        default:
          return data;
      }
    }
  }
}
