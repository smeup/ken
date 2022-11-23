import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

enum ChartType { Pie, Bar }

class KenChartModel extends KenModel {
  static const ChartType defaultChartType = ChartType.Bar;
  static const int defaultRefresh = -1;
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const bool defaultLegend = true;

  ChartType? chartType;
  //int refresh;
  double? width;
  double? height;
  bool? legend;

  KenChartModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    title = '',
    this.chartType = defaultChartType,
    //this.refresh = defaultRefresh,
    this.height = defaultHeight,
    this.width = defaultWidth,
    this.legend = defaultLegend,
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type,instanceCallBack: instanceCallBack) {
  }

  KenChartModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack, null)  {
    if (optionsDefault!['Typ'] == null) {
      chartType = defaultChartType;
    } else {
      if (optionsDefault!['Typ'] is List) {
        chartType = _getChartType(optionsDefault!['Typ'][0]);
      } else {
        chartType = _getChartType(optionsDefault!['Typ']);
      }
    }
    if (chartType == null) chartType = defaultChartType;
    //refresh = optionsDefault['refresh'] ?? defaultRefresh;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    legend =
        KenUtilities.getBool(optionsDefault!['showMarks']) ?? defaultLegend;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {

        await this.getData(instanceCallBack);
        // await SmeupChartDao.getData(this);
      };
    }

  }

  ChartType? _getChartType(String? type) {
    switch (type) {
      case 'VBAR':
        return ChartType.Bar;
      case 'pie':
        return ChartType.Pie;
      default:
        return null;
    }
  }
}