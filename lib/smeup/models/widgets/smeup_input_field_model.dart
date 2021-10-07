import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupInputFieldModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;

  Color backColor;
  double fontsize;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  dynamic clientData;
  bool showUnderline;
  bool autoFocus;

  SmeupInputFieldModel(GlobalKey<FormState> formKey,
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
      : super(formKey, title: title) {
    if (backColor == null)
      backColor = SmeupConfigurationService.getTheme().backgroundColor;
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupInputFieldModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    label = optionsDefault['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
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

      data = smeupServiceResponse.result.data;
    }

    if (clientData != null) {
      data = _getClientDataStructure(clientData);
    }
    SmeupDataService.decrementDataFetch(id);
  }

  SmeupInputFieldModel clone() {
    return SmeupInputFieldModel(formKey,
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
