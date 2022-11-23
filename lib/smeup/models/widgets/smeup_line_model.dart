import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_line_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupModel {
  // supported by json_theme
  static Color? defaultColor;
  static double? defaultThickness;

  // unsupported by json_theme

  Color? color;
  double? thickness;

  SmeupLineModel(
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context, {
    this.color,
    this.thickness,
  }) : super(formKey, scaffoldKey, context, title: '', id: id, type: type) {
    id = SmeupUtilities.getWidgetId('LIN', id);
    setDefaults(this);
  }

  SmeupLineModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    setDefaults(this);

    thickness = SmeupUtilities.getDouble(optionsDefault!['thickness']) ??
        defaultThickness;

    color =
        SmeupUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupLineDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    DividerThemeData dividerData =
        SmeupConfigurationService.getTheme()!.dividerTheme;

    defaultColor = dividerData.color;
    defaultThickness = dividerData.thickness;

    // ----------------- set properties from default
    if (obj.color == null) obj.color = defaultColor;
    if (obj.thickness == null) obj.thickness = defaultThickness;
  }
}
