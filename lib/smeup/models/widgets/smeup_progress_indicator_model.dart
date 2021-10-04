import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupProgressIndicatorModel extends SmeupModel
    implements SmeupDataInterface {
  static const Color defaultColor = Colors.blue;

  Color color;

  SmeupProgressIndicatorModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.color = defaultColor,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupProgressIndicatorModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']) ??
          defaultColor;
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
