import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupModel {
  Color color = Colors.white;
  double thickness = 0;

  SmeupLineModel(GlobalKey<FormState> formKey, {this.color, this.thickness})
      : super(formKey, title: '') {
    id = SmeupUtilities.getWidgetId('LIN', id);
  }

  SmeupLineModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    thickness = SmeupUtilities.getDouble(optionsDefault['thickness']) ?? 0;
    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']);
    }
  }
}
