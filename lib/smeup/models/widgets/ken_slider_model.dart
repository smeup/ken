import 'package:flutter/material.dart';

import '../../services/ken_utilities.dart';
import 'ken_model.dart';

class KenSliderModel extends KenModel {
  // supported by json_theme
  static const Color defaultActiveTrackColor = KenModel.kPrimary;
  static const Color defaultThumbColor = KenModel.kPrimary;
  static const Color defaultInactiveTrackColor = KenModel.kInactivePrimary;
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
    this.activeTrackColor = defaultActiveTrackColor,
    this.thumbColor = defaultThumbColor,
    this.inactiveTrackColor = defaultInactiveTrackColor,
    this.padding = defaultPadding,
    this.sldMin = defaultSldMin,
    this.sldMax = defaultSldMax,
  }) : super(formKey, scaffoldKey, context, title: '', id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'sld';
    id = KenUtilities.getWidgetId('FLD', id);
  }

  KenSliderModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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

    if (widgetLoadType != LoadType.delay) {
      onReady = () async {
        // await SmeupSliderDao.getData(this);
        await getData();
      };
    }
  }
}
