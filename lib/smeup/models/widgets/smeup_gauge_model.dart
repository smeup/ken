import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_gauge_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

class SmeupGaugeModel extends SmeupModel implements SmeupDataInterface {
  //SmeupGaugeModel(GlobalKey<FormState> formKey, {title = ''})
  //: super(formKey, title: title) {
  //id = SmeupUtilities.getWidgetId('GAU', id);
  //SmeupDataService.incrementDataFetch(id);
  //}

  static const String defaultValColName = 'value';
  static const String defaultMaxColName = 'maxValue';
  static const String defaultWarningColName = 'warning';

  String valueColName;
  String warningColName;
  String maxColName;

  SmeupGaugeModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.valueColName = defaultValColName,
      this.warningColName = defaultWarningColName,
      this.maxColName = defaultMaxColName,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupGaugeModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (widgetLoadType != LoadType.Delay) {
      SmeupGaugeDao.getData(this);
    }
    title = jsonMap['title'] ?? '';
    valueColName = optionsDefault['valueColName'] ?? defaultValColName;
    maxColName = optionsDefault['maxColName'] ?? defaultMaxColName;
    warningColName = optionsDefault['warningColName'] ?? defaultWarningColName;
    SmeupDataService.incrementDataFetch(id);
  }
}
