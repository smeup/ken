import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_chart_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

enum ChartType { Pie, Bar }

class SmeupChartModel extends SmeupModel {
  static const ChartType defaultChartType = ChartType.Bar;
  static const int defaultRefresh = -1;
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const bool defaultLegend = true;

  ChartType chartType;
  //int refresh;
  double width;
  double height;
  bool legend;

  SmeupChartModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    title = '',
    this.chartType = defaultChartType,
    //this.refresh = defaultRefresh,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.legend = defaultLegend,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupChartModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    if (optionsDefault['Typ'] == null) {
      chartType = defaultChartType;
    } else {
      if (optionsDefault['Typ'] is List) {
        chartType = _getChartType(optionsDefault['Typ'][0]);
      } else {
        chartType = _getChartType(optionsDefault['Typ']);
      }
    }
    if (chartType == null) chartType = defaultChartType;
    //refresh = optionsDefault['refresh'] ?? defaultRefresh;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    legend =
        SmeupUtilities.getBool(optionsDefault['showMarks']) ?? defaultLegend;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupChartDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  ChartType _getChartType(String type) {
    switch (type) {
      case 'VBAR':
        return ChartType.Bar;
        break;
      case 'pie':
        return ChartType.Pie;
        break;
      default:
        return null;
    }
  }
}
