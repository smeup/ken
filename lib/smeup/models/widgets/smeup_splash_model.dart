import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupSplashModel extends SmeupModel implements SmeupDataInterface {
  Color color;

  SmeupSplashModel(
      {id, type, GlobalKey<FormState> formKey, this.color, title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (color == null) color = SmeupConfigurationService.defaultSplashColor;
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'spl';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupSplashModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']) ??
          SmeupConfigurationService.defaultSplashColor;
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
