import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_chart_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum ChartType { Pie, Bar }

class SmeupChartModel extends SmeupModel {
  static const ChartType defaultChartType = ChartType.Bar;
  static const int defaultRefresh = -1;
  static const double defaultWidth = 0;
  static const double defaultHeight = 0;
  static const bool defaultLegend = true;

  ChartType chartType;
  int refresh;
  double width;
  double height;
  bool legend;

  SmeupChartModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    title = '',
    this.chartType = defaultChartType,
    this.refresh = defaultRefresh,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.legend = defaultLegend,
  }) : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupChartModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    chartType = optionsDefault['types'][0] ?? defaultChartType;
    refresh = optionsDefault['refresh'] ?? defaultRefresh;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    legend = optionsDefault['leg'] ?? defaultLegend;

    if (widgetLoadType != LoadType.Delay) {
      SmeupChartDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
