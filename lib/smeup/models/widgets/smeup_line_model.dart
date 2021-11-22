import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_line_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLineModel extends SmeupModel {
  // supported by json_theme
  static Color defaultColor;

  // unsupported by json_theme
  static const double defaultThickness = 1;

  Color color;
  double thickness;

  SmeupLineModel(
    id,
    type,
    GlobalKey<FormState> formKey, {
    this.color,
    this.thickness = defaultThickness,
  }) : super(formKey, title: '', id: id, type: type) {
    id = SmeupUtilities.getWidgetId('LIN', id);
    SmeupLineModel.setDefaults(this);
  }

  SmeupLineModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    SmeupLineModel.setDefaults(this);
    thickness = SmeupUtilities.getDouble(optionsDefault['thickness']) ??
        defaultThickness;
    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']);
    } else {
      color = defaultColor;
    }
    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupLineDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    TextStyle captionStyle =
        SmeupConfigurationService.getTheme().textTheme.copyWith().caption;

    defaultColor = captionStyle.color;
  }
}
