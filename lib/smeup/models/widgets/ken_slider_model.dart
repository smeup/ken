import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_configuration_service.dart';

class KenSliderModel extends KenModel {
  // supported by json_theme
  static Color? defaultActiveTrackColor;
  static Color? defaultThumbColor;
  static Color? defaultInactiveTrackColor;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const double defaultSldMin = 0;
  static const double defaultSldMax = 100;

  Color? activeTrackColor;
  Color? thumbColor;
  Color? inactiveTrackColor;
  EdgeInsetsGeometry? padding;
  double? sldMin;
  double? sldMax;

  String? label;

  KenSliderModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.activeTrackColor,
    this.thumbColor,
    this.inactiveTrackColor,
    this.padding = defaultPadding,
    this.sldMin = defaultSldMin,
    this.sldMax = defaultSldMax,
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: '', id: id, type: type, instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'sld';
    id = KenUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  KenSliderModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack, null) {
    setDefaults(this);

    sldMin = KenUtilities.getDouble(optionsDefault!['sldMin']) ?? defaultSldMin;
    sldMax = KenUtilities.getDouble(optionsDefault!['sldMax']) ?? defaultSldMax;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    thumbColor = KenUtilities.getColorFromRGB(optionsDefault!['thumbColor']) ??
        defaultThumbColor;

    activeTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['activeTrackColor']) ??
            defaultActiveTrackColor;

    inactiveTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['inactiveTrackColor']) ??
            defaultInactiveTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupSliderDao.getData(this);
        await this.getData(instanceCallBack);
      };
    }
  }

  static setDefaults(dynamic obj) {
    SliderThemeData sliderThemeData =
        KenConfigurationService.getTheme()!.sliderTheme;
    defaultActiveTrackColor = sliderThemeData.activeTrackColor;
    defaultThumbColor = sliderThemeData.thumbColor;
    defaultInactiveTrackColor = sliderThemeData.inactiveTrackColor;

    // ----------------- set properties from default

    if (obj.activeTrackColor == null)
      obj.activeTrackColor = KenSliderModel.defaultActiveTrackColor;
    if (obj.thumbColor == null)
      obj.thumbColor = KenSliderModel.defaultThumbColor;
    if (obj.inactiveTrackColor == null)
      obj.inactiveTrackColor = KenSliderModel.defaultInactiveTrackColor;
  }
}
