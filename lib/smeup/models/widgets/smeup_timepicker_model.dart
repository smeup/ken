import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_timepicker_dao.dart';
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
  static const Color defaultBackColor = Colors.amber;
  static const Color defaultFontColor = Colors.black87;

  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  String valueField;
  String displayedField;
  double padding;
  bool showborder;
  List<String> minutesList;

  SmeupTimePickerModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.valueField = '',
      this.displayedField = '',
      this.backColor = defaultBackColor,
      this.fontsize = defaultFontsize,
      this.fontColor = defaultFontColor,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      title = '',
      this.minutesList})
      : super(formKey, title: title, id: id, type: type) {
    if (backColor == null) backColor = SmeupOptions.theme.backgroundColor;
    if (fontColor == null)
      fontColor = SmeupOptions.theme.textTheme.bodyText1.color;
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTimePickerModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    valueField = optionsDefault['valueField'] ?? 'value';
    displayedField = optionsDefault['displayedField'] ?? 'display';

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

    if (widgetLoadType != LoadType.Delay) {
      SmeupTimePickerDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
