import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class KenSplashModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultColor;

  Color? color;

  KenSplashModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.color,
      title = '',
        required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
      })
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type, instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'spl';
    setDefaults(this);
  }

  KenSplashModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

  }

  static setDefaults(dynamic obj) {
    defaultColor = KenThemeConfigurationService.getTheme()!.splashColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = KenSplashModel.defaultColor;
  }
}