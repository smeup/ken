import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_line_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupModel {
  static const Color defaultColor = Colors.black;
  static const double defaultThickness = 5;

  Color color;
  double thickness;

  SmeupLineModel(
    id,
    type,
    GlobalKey<FormState> formKey, {
    this.color = defaultColor,
    this.thickness = defaultThickness,
  }) : super(formKey, title: '', id: id, type: type) {
    id = SmeupUtilities.getWidgetId('LIN', id);
  }

  SmeupLineModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    thickness = SmeupUtilities.getDouble(optionsDefault['thickness']) ??
        defaultThickness;
    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']);
    } else {
      color = defaultColor;
    }
    if (widgetLoadType != LoadType.Delay) {
      SmeupLineDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
