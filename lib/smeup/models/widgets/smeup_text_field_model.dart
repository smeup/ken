import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTextFieldModel extends SmeupModel implements SmeupDataInterface {
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

  SmeupTextFieldModel(
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
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTextFieldModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    label = optionsDefault['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
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
  // ignore: override_on_non_overriding_member
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      // List rows = smeupServiceResponse.result.data['rows'];
      // if (smeupFun.fun['fun']['component'] == 'TRE') {
      //   final String fieldName = 'codice';
      //   optionsDefault['valueField'] = fieldName;
      //   String value = (rows[0] as Node).data[fieldName];
      //   data = _getClientDataStructure(value, fieldName: fieldName);
      // } else {
      data = smeupServiceResponse.result.data;
      // }
    }

    if (clientData != null) {
      data = _getClientDataStructure(clientData);
    }
    SmeupDataService.decrementDataFetch(id);
  }

  SmeupTextFieldModel clone() {
    return SmeupTextFieldModel(
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

  dynamic _getClientDataStructure(String fieldData,
      {String fieldName = 'value'}) {
    if (optionsDefault == null) {
      return {
        "rows": [
          {
            fieldName: fieldData,
          }
        ],
      };
    } else {
      switch (optionsDefault['type']) {
        case 'itx':
          return {
            "rows": [
              {
                fieldName: fieldData,
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
