import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_chart_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

class SmeupChartModel extends SmeupModel {
  SmeupChartModel({id, type, GlobalKey<FormState> formKey, title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupChartModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (widgetLoadType != LoadType.Delay) {
      SmeupChartDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
