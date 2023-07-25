import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenWaitModel extends KenModel implements KenDataInterface {
  static Color? defaultSplashColor = KenModel.kIconColor;
  static Color? defaultLoaderColor = KenModel.kIconColor;
  static Color? defaultcircularTrackColor;

  Color? splashColor;
  Color? loaderColor;
  Color? circularTrackColor;

  KenWaitModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.splashColor,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'wai';
  }

  KenWaitModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';

    splashColor =
        KenUtilities.getColorFromRGB(optionsDefault!['splashColor']) ??
            defaultSplashColor;
    loaderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['loaderColor']) ??
            defaultLoaderColor;
    circularTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['circularTrackColor']) ??
            defaultcircularTrackColor;
  }

  static setDefaults(dynamic obj) {
    defaultSplashColor = KenConfigurationService.getTheme()!.splashColor;
    defaultLoaderColor = KenConfigurationService.getTheme()!.splashColor;
    defaultcircularTrackColor = KenConfigurationService.getTheme()!
        .progressIndicatorTheme
        .circularTrackColor;

    // ----------------- set properties from default

    obj.splashColor ??= KenWaitModel.defaultSplashColor;
    obj.loaderColor ??= KenWaitModel.defaultSplashColor;
    obj.circularTrackColor ??= KenWaitModel.defaultcircularTrackColor;
  }
}
