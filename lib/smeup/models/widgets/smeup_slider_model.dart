import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_slider_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupSliderModel extends SmeupModel {
  // supported by json_theme
  static Color defaultActiveTrackColor;
  static Color defaultThumbColor;
  static Color defaultInactiveTrackColor;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const double defaultSldMin = 0;
  static const double defaultSldMax = 100;

  Color activeTrackColor;
  Color thumbColor;
  Color inactiveTrackColor;
  EdgeInsetsGeometry padding;
  double sldMin;
  double sldMax;

  SmeupSliderModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    this.activeTrackColor,
    this.thumbColor,
    this.inactiveTrackColor,
    this.padding = defaultPadding,
    this.sldMin = defaultSldMin,
    this.sldMax = defaultSldMax,
  }) : super(formKey, title: '', id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'sld';
    id = SmeupUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  SmeupSliderModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);

    sldMin =
        SmeupUtilities.getDouble(optionsDefault['sldMin']) ?? defaultSldMin;
    sldMax =
        SmeupUtilities.getDouble(optionsDefault['sldMax']) ?? defaultSldMax;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    thumbColor = SmeupUtilities.getColorFromRGB(optionsDefault['thumbColor']) ??
        defaultThumbColor;

    activeTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['activeTrackColor']) ??
            defaultActiveTrackColor;

    inactiveTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['inactiveTrackColor']) ??
            defaultInactiveTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupSliderDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    SliderThemeData sliderThemeData =
        SmeupConfigurationService.getTheme().sliderTheme;
    defaultActiveTrackColor = sliderThemeData.activeTrackColor;
    defaultThumbColor = sliderThemeData.thumbColor;
    defaultInactiveTrackColor = sliderThemeData.inactiveTrackColor;

    // ----------------- set properties from default

    if (obj.activeTrackColor == null)
      obj.activeTrackColor = SmeupSliderModel.defaultActiveTrackColor;
    if (obj.thumbColor == null)
      obj.thumbColor = SmeupSliderModel.defaultThumbColor;
    if (obj.inactiveTrackColor == null)
      obj.inactiveTrackColor = SmeupSliderModel.defaultInactiveTrackColor;
  }
}
