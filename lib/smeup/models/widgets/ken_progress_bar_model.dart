import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_theme_configuration_service.dart';

class KenProgressBarModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultColor;
  static Color? defaultLinearTrackColor;

  // unsupported by json_theme
  static const String defaultValueField = 'value';
  static const double defaultProgressBarMinimun = 0;
  static const double defaultProgressBarMaximun = 0;
  static const double defaultHeight = 10;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  Color? color;
  Color? linearTrackColor;
  String? valueField;
  double? progressBarMinimun;
  double? progressBarMaximun;
  double? height;
  EdgeInsetsGeometry? padding;

  KenProgressBarModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.color,
      this.linearTrackColor,
      this.height = defaultHeight,
      this.valueField = defaultValueField,
      this.padding = defaultPadding,
      this.progressBarMinimun = defaultProgressBarMinimun,
      this.progressBarMaximun = defaultProgressBarMaximun,
      title = '',
        required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
      })
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type, instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgb';
    setDefaults(this);
  }

  KenProgressBarModel.fromMap(
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

    valueField = optionsDefault!['valueField'] ?? defaultValueField;

    progressBarMinimun = KenUtilities.getDouble(optionsDefault!['pgbMin']) ??
        defaultProgressBarMinimun;
    progressBarMaximun = KenUtilities.getDouble(optionsDefault!['pgbMax']) ??
        defaultProgressBarMaximun;
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;

    color =
        KenUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    linearTrackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['linearTrackColor']) ??
            defaultLinearTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupProgressBarDao.getData(this);
        await this.getData(instanceCallBack);
      };
    }

  }

  static setDefaults(dynamic obj) {
    ProgressIndicatorThemeData progressIndicatorThemeData =
        KenThemeConfigurationService.getTheme()!.progressIndicatorTheme;
    defaultColor = progressIndicatorThemeData.color;
    defaultLinearTrackColor = progressIndicatorThemeData.linearTrackColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = KenProgressBarModel.defaultColor;
    if (obj.linearTrackColor == null)
      obj.linearTrackColor = KenProgressBarModel.defaultLinearTrackColor;
  }
}