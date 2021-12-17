import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupProgressIndicatorModel extends SmeupModel
    implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultColor;
  static Color defaultCircularTrackColor;

  // unsupported by json_theme
  static const double defaultSize = 30;

  Color color;
  Color circularTrackColor;
  double size;

  SmeupProgressIndicatorModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.color,
      this.circularTrackColor,
      this.size = defaultSize,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pgi';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupProgressIndicatorModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';

    size = SmeupUtilities.getDouble(optionsDefault['size']) ?? defaultSize;

    color =
        SmeupUtilities.getColorFromRGB(optionsDefault['color']) ?? defaultColor;

    circularTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['circularTrackColor']) ??
            defaultCircularTrackColor;

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    ProgressIndicatorThemeData progressIndicatorThemeData =
        SmeupConfigurationService.getTheme().progressIndicatorTheme;
    defaultColor = progressIndicatorThemeData.color;
    defaultCircularTrackColor = progressIndicatorThemeData.circularTrackColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = SmeupProgressIndicatorModel.defaultColor;
    if (obj.circularTrackColor == null)
      obj.circularTrackColor =
          SmeupProgressIndicatorModel.defaultCircularTrackColor;
  }
}
