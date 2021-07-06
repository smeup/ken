import 'dart:math';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupComponentModel {
  Color color = Colors.white;
  double thickness = 0;

  SmeupLineModel({this.color, this.thickness}) : super(title: '') {
    id = 'LIN' + Random().nextInt(100).toString();
  }

  SmeupLineModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    thickness = getDouble(optionsDefault['thickness']) ?? 0;
    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']);
    }
  }
}
