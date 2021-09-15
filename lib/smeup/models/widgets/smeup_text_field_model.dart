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
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
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
  EdgeInsetsGeometry padding;
  bool showborder;
  bool showUnderline;
  bool autoFocus;
  String valueField;
  bool showSubmit;
  TextInputType keyboard;

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
      this.showUnderline = defaultShowUnderline,
      this.autoFocus = defaultAutoFocus,
      this.valueField,
      this.keyboard})
      : super(title: title, id: id, type: type) {
    if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'itx';
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
    padding = SmeupUtilities.getPadding(optionsDefault['padding']);
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
    keyboard = SmeupUtilities.getKeyboard(optionsDefault['keyboard']);

    if (widgetLoadType != LoadType.Delay) {
      SmeupTextFieldDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTextFieldModel clone() {
    return SmeupTextFieldModel(
        id: id,
        type: type,
        backColor: backColor,
        fontsize: fontsize,
        label: label,
        width: width,
        height: height,
        padding: padding,
        showborder: showborder,
        showUnderline: showUnderline);
  }
}
