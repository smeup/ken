import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupWaitModel extends SmeupModel implements SmeupDataInterface {
  static Color? defaultSplashColor;
  static Color? defaultLoaderColor;
  static Color? defaultcircularTrackColor;

  Color? splashColor;
  Color? loaderColor;
  Color? circularTrackColor;

  SmeupWaitModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.splashColor,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'wai';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupWaitModel.fromMap(
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

    splashColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['splashColor']) ??
            defaultSplashColor;
    loaderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['loaderColor']) ??
            defaultLoaderColor;
    circularTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['circularTrackColor']) ??
            defaultcircularTrackColor;

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    defaultSplashColor = SmeupConfigurationService.getTheme()!.splashColor;
    defaultLoaderColor = SmeupConfigurationService.getTheme()!.splashColor;
    defaultcircularTrackColor = SmeupConfigurationService.getTheme()!
        .progressIndicatorTheme
        .circularTrackColor;

    // ----------------- set properties from default

    if (obj.splashColor == null)
      obj.splashColor = SmeupWaitModel.defaultSplashColor;
    if (obj.loaderColor == null)
      obj.loaderColor = SmeupWaitModel.defaultSplashColor;
    if (obj.circularTrackColor == null)
      obj.circularTrackColor = SmeupWaitModel.defaultcircularTrackColor;
  }
}
