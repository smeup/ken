import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_field_dao.dart';
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
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultShowUnderline = true;

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
  String valueField;
  bool showSubmit;

  SmeupTextFieldModel(
      {id,
      type,
      this.backColor,
      this.fontsize = defaultFontsize,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      this.showSubmit = defaultShowSubmit,
      title = '',
      this.clientData,
      this.showUnderline = defaultShowUnderline,
      this.autoFocus = defaultAutoFocus,
      this.valueField})
      : super(title: title, id: id, type: type) {
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
    valueField = optionsDefault['valueField'] ?? defaultValueField;
    showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
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

    if (widgetLoadType != LoadType.Delay) {
      SmeupTextFieldDao.getData(this).then((value) {
        data = value;
      });
    }

    SmeupDataService.incrementDataFetch(id);
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
}
