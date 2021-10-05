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
  static const double defaultHeight = 10;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  Color color;
  String valueField;
  double progressBarMinimun;
  double progressBarMaximun;
  double height;
  EdgeInsetsGeometry padding;

  SmeupProgressBarModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.color = defaultColor,
      this.height = defaultHeight,
      this.valueField = defaultValueField,
      this.padding = defaultPadding,
      this.progressBarMinimun = defaultProgressBarMinimun,
      this.progressBarMaximun = defaultProgressBarMaximun,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pgb';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupProgressBarModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault['valueField'] ?? defaultValueField;

    progressBarMinimun = SmeupUtilities.getDouble(optionsDefault['pgbMin']) ??
        defaultProgressBarMinimun;
    progressBarMaximun = SmeupUtilities.getDouble(optionsDefault['pgbMax']) ??
        defaultProgressBarMaximun;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    padding = SmeupUtilities.getPadding(optionsDefault['padding']);

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
