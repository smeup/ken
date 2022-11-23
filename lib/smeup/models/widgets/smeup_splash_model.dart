import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupSplashModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color? defaultColor;

  Color? color;

  SmeupSplashModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.color,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'spl';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupSplashModel.fromMap(
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

    color =
        SmeupUtilities.getColorFromRGB(optionsDefault!['color']) ?? defaultColor;

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    defaultColor = SmeupConfigurationService.getTheme()!.splashColor;

    // ----------------- set properties from default

    if (obj.color == null) obj.color = SmeupSplashModel.defaultColor;
  }
}
