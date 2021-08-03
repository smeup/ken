import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupModel {
  Color color = Colors.white;
  double thickness = 0;

  SmeupLineModel({this.color, this.thickness}) : super(title: '') {
    id = SmeupUtilities.getWidgetId('LIN', id);
  }

  SmeupLineModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    thickness = SmeupUtilities.getDouble(optionsDefault['thickness']) ?? 0;
    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']);
    }
  }
}
