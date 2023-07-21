// ignore_for_file: prefer_conditional_assignment

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenLineModel extends KenModel {
  // supported by json_theme
  static Color? defaultColor = KenModel.kButtonBackgroundColor;
  static double? defaultThickness = 1;

  // unsupported by json_theme

  Color? color;
  double? thickness;

  KenLineModel(
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context, {
    this.color,
    this.thickness,
  }) : super(formKey, scaffoldKey, context, title: '', id: id, type: type) {
    id = KenUtilities.getWidgetId('LIN', id);
    setDefaults(this);
  }

  KenLineModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    thickness = KenUtilities.getDouble(optionsDefault!['thickness']) ??
        defaultThickness;

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupLineDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    DividerThemeData dividerData =
        KenConfigurationService.getTheme()!.dividerTheme;

    defaultColor = dividerData.color;
    defaultThickness = dividerData.thickness;

    // ----------------- set properties from default
    if (obj.color == null) obj.color = defaultColor;
    if (obj.thickness == null) obj.thickness = defaultThickness;
  }
}
