import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupProgressIndicatorModel extends SmeupModel
    implements SmeupDataInterface {
  // supported by json_theme
  static Color? defaultColor;
  static Color? defaultCircularTrackColor;

  // unsupported by json_theme
  static const double defaultSize = 30;

  Color? color;
  Color? circularTrackColor;
  double? size;

  SmeupProgressIndicatorModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.color,
      this.circularTrackColor,
      this.size = defaultSize,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'pgi';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupProgressIndicatorModel.fromMap(
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
    title = jsonMap['title'] ?? '';

    size = SmeupUtilities.getDouble(optionsDefault!['size']) ?? defaultSize;

    color =
        SmeupUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    circularTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['circularTrackColor']) ??
            defaultCircularTrackColor;

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    ProgressIndicatorThemeData progressIndicatorThemeData =
        SmeupConfigurationService.getTheme()!.progressIndicatorTheme;
    defaultColor = progressIndicatorThemeData.color;
    defaultCircularTrackColor = progressIndicatorThemeData.circularTrackColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = SmeupProgressIndicatorModel.defaultColor;
    if (obj.circularTrackColor == null)
      obj.circularTrackColor =
          SmeupProgressIndicatorModel.defaultCircularTrackColor;
  }
}
