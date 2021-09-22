import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTimePickerModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const double defaultPadding = 0.0;
  static const bool defaultShowBorder = false;

  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  dynamic clientData;
  List<String> minutesList;

  SmeupTimePickerModel(GlobalKey<FormState> formKey,
      {this.backColor,
      this.fontsize = defaultFontsize,
      this.fontColor,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      title = '',
      this.clientData,
      this.minutesList})
      : super(formKey, title: title) {
    if (backColor == null)
      backColor = SmeupConfigurationService.getTheme().backgroundColor;
    if (fontColor == null)
      fontColor =
          SmeupConfigurationService.getTheme().textTheme.bodyText1.color;
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTimePickerModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }
    label = optionsDefault['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    if (optionsDefault['minutesList'] == null) {
      minutesList = null;
    } else {
      minutesList = (optionsDefault['minutesList'] as List)
          .map((e) => e.toString())
          .toList();
    }

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

  dynamic _getClientDataStructure(clientData) {
    if (optionsDefault == null) {
      return {
        "rows": [
          {
            'value': clientData['value'],
            'display': clientData['display'],
          }
        ],
      };
    } else {
      return {
        "rows": [
          {
            'value': clientData['value'],
            'display': clientData['display'],
          }
        ],
      };
    }
  }
}
