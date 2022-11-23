import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_theme_configuration_service.dart';

class KenWaitModel extends KenModel implements KenDataInterface {
  static Color? defaultSplashColor;
  static Color? defaultLoaderColor;
  static Color? defaultcircularTrackColor;

  Color? splashColor;
  Color? loaderColor;
  Color? circularTrackColor;

  KenWaitModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.splashColor,
      title = '',
        required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack
      })
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type,instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'wai';
  }

  KenWaitModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,

  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
          instanceCallBack,
          null
        ) {
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
    defaultSplashColor = KenThemeConfigurationService.getTheme()!.splashColor;
    defaultLoaderColor = KenThemeConfigurationService.getTheme()!.splashColor;
    defaultcircularTrackColor = KenThemeConfigurationService.getTheme()!
        .progressIndicatorTheme
        .circularTrackColor;

    // ----------------- set properties from default

    if (obj.splashColor == null)
      obj.splashColor = KenWaitModel.defaultSplashColor;
    if (obj.loaderColor == null)
      obj.loaderColor = KenWaitModel.defaultSplashColor;
    if (obj.circularTrackColor == null)
      obj.circularTrackColor = KenWaitModel.defaultcircularTrackColor;
  }
}
