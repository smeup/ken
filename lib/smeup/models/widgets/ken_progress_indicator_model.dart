import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../../services/ken_configuration_service.dart';

class KenProgressIndicatorModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultColor;
  static Color? defaultCircularTrackColor;

  // unsupported by json_theme
  static const double defaultSize = 30;

  Color? color;
  Color? circularTrackColor;
  double? size;

  KenProgressIndicatorModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.color,
    this.circularTrackColor,
    this.size = defaultSize,
    title = '',
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgi';
    setDefaults(this);
  }

  KenProgressIndicatorModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';

    size = KenUtilities.getDouble(optionsDefault!['size']) ?? defaultSize;

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    circularTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['circularTrackColor']) ??
            defaultCircularTrackColor;
  }

  static setDefaults(dynamic obj) {
    ProgressIndicatorThemeData progressIndicatorThemeData =
        KenConfigurationService.getTheme()!.progressIndicatorTheme;
    defaultColor = progressIndicatorThemeData.color;
    defaultCircularTrackColor = progressIndicatorThemeData.circularTrackColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = KenProgressIndicatorModel.defaultColor;
    if (obj.circularTrackColor == null)
      obj.circularTrackColor =
          KenProgressIndicatorModel.defaultCircularTrackColor;
  }
}
