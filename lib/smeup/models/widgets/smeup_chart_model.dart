import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_chart_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

enum ChartType { Area, Line, Bar }

class SmeupChartModel extends SmeupModel {
  static const ChartType defaultChartType = ChartType.Bar;
  static const int defaultRefresh = -1;

  ChartType chartType;
  int refresh;

  SmeupChartModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      title = '',
      this.chartType = defaultChartType,
      this.refresh = defaultRefresh})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupChartModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    chartType = optionsDefault['types'][0] ?? defaultChartType;
    refresh = optionsDefault['refresh'] ?? defaultRefresh;

    if (widgetLoadType != LoadType.Delay) {
      SmeupChartDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
