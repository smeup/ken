import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenSplashModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultColor = KenModel.kButtonBackgroundColor;

  Color? color;

  KenSplashModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.color,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'spl';
    setDefaults(this);
  }

  KenSplashModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;
  }

  static setDefaults(dynamic obj) {
    defaultColor = KenConfigurationService.getTheme()!.splashColor;

    // ----------------- set properties from default

    obj.color ??= KenSplashModel.defaultColor;
  }
}
