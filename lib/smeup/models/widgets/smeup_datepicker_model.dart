import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_datepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDatePickerModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultFontsize = 16.0;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 20;
  static const double defaultPadding = 10.0;
  static const bool defaultShowBorder = false;
  static const double defaultElevation = 0.0;

  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  double elevation;

  List<String> minutesList;

  SmeupDatePickerModel(
      {GlobalKey<FormState> formKey,
      id,
      type,
      this.backColor,
      this.fontsize = defaultFontsize,
      this.fontColor,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showborder = defaultShowBorder,
      this.elevation = defaultElevation,
      title = '',
      this.minutesList})
      : super(formKey, id: id, type: type, title: title) {
    if (backColor == null)
      backColor = SmeupConfigurationService.getTheme().backgroundColor;
    if (fontColor == null)
      fontColor =
          SmeupConfigurationService.getTheme().textTheme.bodyText1.color;
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupDatePickerModel.fromMap(
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
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;
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
      SmeupDatePickerDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
