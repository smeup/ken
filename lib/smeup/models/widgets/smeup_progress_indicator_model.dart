import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupProgressIndicatorModel extends SmeupModel
    implements SmeupDataInterface {
  static const Color defaultColor = Colors.blue;
  static const double defaultSize = 30;

  double size;
  Color color;

  SmeupProgressIndicatorModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.color = defaultColor,
      this.size = defaultSize,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pgi';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupProgressIndicatorModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    size = SmeupUtilities.getDouble(optionsDefault['size']) ?? defaultSize;

    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']) ??
          defaultColor;
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
