import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_progress_bar_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupProgressBarModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultColor;
  static Color defaultLinearTrackColor;

  // unsupported by json_theme
  static const String defaultValueField = 'value';
  static const double defaultProgressBarMinimun = 0;
  static const double defaultProgressBarMaximun = 0;
  static const double defaultHeight = 10;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  Color color;
  Color linearTrackColor;
  String valueField;
  double progressBarMinimun;
  double progressBarMaximun;
  double height;
  EdgeInsetsGeometry padding;

  SmeupProgressBarModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      this.color,
      this.linearTrackColor,
      this.height = defaultHeight,
      this.valueField = defaultValueField,
      this.padding = defaultPadding,
      this.progressBarMinimun = defaultProgressBarMinimun,
      this.progressBarMaximun = defaultProgressBarMaximun,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pgb';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupProgressBarModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault['valueField'] ?? defaultValueField;

    progressBarMinimun = SmeupUtilities.getDouble(optionsDefault['pgbMin']) ??
        defaultProgressBarMinimun;
    progressBarMaximun = SmeupUtilities.getDouble(optionsDefault['pgbMax']) ??
        defaultProgressBarMaximun;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    color =
        SmeupUtilities.getColorFromRGB(optionsDefault['color']) ?? defaultColor;

    linearTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['linearTrackColor']) ??
            defaultLinearTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupProgressBarDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    ProgressIndicatorThemeData progressIndicatorThemeData =
        SmeupConfigurationService.getTheme().progressIndicatorTheme;
    defaultColor = progressIndicatorThemeData.color;
    defaultLinearTrackColor = progressIndicatorThemeData.linearTrackColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = SmeupProgressBarModel.defaultColor;
    if (obj.linearTrackColor == null)
      obj.linearTrackColor = SmeupProgressBarModel.defaultLinearTrackColor;
  }
}
