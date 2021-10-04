import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_progress_bar_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupProgressBarModel extends SmeupModel implements SmeupDataInterface {
  static const Color defaultColor = Colors.blue;
  static const String defaultValueField = 'value';
  static const double defaultProgressBarMinimun = 0;
  static const double defaultProgressBarMaximun = 0;

  Color color;
  String valueField;
  double progressBarMinimun;
  double progressBarMaximun;

  SmeupProgressBarModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.color = defaultColor,
      this.valueField = defaultValueField,
      this.progressBarMinimun = defaultProgressBarMinimun,
      this.progressBarMaximun = defaultProgressBarMaximun,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupProgressBarModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault['valueField'] ?? defaultValueField;

    progressBarMinimun =
        SmeupUtilities.getDouble(optionsDefault['extensions']['pgbMin']) ??
            defaultProgressBarMinimun;
    progressBarMaximun =
        SmeupUtilities.getDouble(optionsDefault['extensions']['pgbMax']) ??
            defaultProgressBarMaximun;

    if (optionsDefault['color'] != null) {
      color = SmeupUtilities.getColorFromRGB(optionsDefault['color']) ??
          defaultColor;
    }

    if (widgetLoadType != LoadType.Delay) {
      SmeupProgressBarDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
