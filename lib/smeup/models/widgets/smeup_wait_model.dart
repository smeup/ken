import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupWaitModel extends SmeupModel implements SmeupDataInterface {
  Color splashColor;
  Color loaderColor;
  Color circularTrackColor;

  SmeupWaitModel(
      {id, type, GlobalKey<FormState> formKey, this.splashColor, title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'wai';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupWaitModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    splashColor = SmeupUtilities.getColorFromRGB(optionsDefault['splashColor']);
    loaderColor = SmeupUtilities.getColorFromRGB(optionsDefault['loaderColor']);
    circularTrackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['circularTrackColor']);

    SmeupDataService.incrementDataFetch(id);
  }
}
