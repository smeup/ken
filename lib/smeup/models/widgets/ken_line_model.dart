import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_configuration_service.dart';

class KenLineModel extends KenModel {
  // supported by json_theme
  static Color? defaultColor;
  static double? defaultThickness;

  // unsupported by json_theme

  Color? color;
  double? thickness;

  KenLineModel(
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack, {
    this.color,
    this.thickness,
  }) : super(formKey, scaffoldKey, context,
            title: '', id: id, type: type, instanceCallBack: instanceCallBack) {
    id = KenUtilities.getWidgetId('LIN', id);
    setDefaults(this);
  }

  KenLineModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    setDefaults(this);

    thickness = KenUtilities.getDouble(optionsDefault!['thickness']) ??
        defaultThickness;

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupLineDao.getData(this);
        await this.getData(instanceCallBack);
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
