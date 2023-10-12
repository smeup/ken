import 'package:flutter/material.dart';
import '../models/widgets/ken_chart_datasource.dart';
import '../services/ken_defaults.dart';

enum ChartType { pie, bar }

class KenChart extends StatefulWidget {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  String? id;
  String? type;
  String? title;
  double? width;
  double? height;
  ChartType? chartType;
  int? refresh;
  bool? legend;

  KenChartDatasource? data;

  KenChart(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CHA',
      this.title = '',
      this.chartType = KenChartDefaults.defaultChartType,
      this.refresh = KenChartDefaults.defaultRefresh,
      this.height = KenChartDefaults.defaultHeight,
      this.width = KenChartDefaults.defaultWidth,
      this.legend = KenChartDefaults.defaultLegend,
      this.data});

  @override
  _KenChartState createState() => _KenChartState();
}

class _KenChartState extends State<KenChart> {
  //KenChartDatasource? _data;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  // Future<KenWidgetBuilderResponse> getChildren() async {
  //   if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
  //     if (_model != null) {
  //       // await SmeupChartDao.getData(_model!);
  //       await _model!.getData();
  //       _data = widget.treatData(_model!);
  //     }
  //     setDataLoad(widget.id, true);
  //   }

  // var children;

//     // TODOO: refresh
//     // if(_model.refreshMilliseconds > 0)
//     // {
//     //   var duration = Duration(milliseconds: smeupChartDatasource.refreshMilliseconds);
//     //   new Timer.periodic(duration, (Timer t) async =>
//     //     response = await smeupHttpService.getScript(smeupChartDatasource.fun)
//     //   );
//     // }

//     switch (widget.chartType) {
//       case ChartType.Bar:
//         children = _getBarChartComponent(_data!);
//         break;
//       case ChartType.Pie:
//         children = _getPieChartComponent(_data!);
//         break;
//       default:
//         KenLogService.writeDebugMessage(
//             'Error SmeupChart charttype not available',
//             logType: KenLogType.error);
//         children = KenNotAvailable();
//     }

//     //children = _getBarChartComponent(_data);

//     return KenWidgetBuilderResponse(_model, children);
//   }

//   /// colAxes = the column which contains the X axes values
//   /// colSeries = the column which contains the Y axes values
//   Widget _getBarChartComponent(KenChartDatasource _data) {
//     var seriesList = _getSeriesList(
//         _data, _model, (KenChartSeries seriesData, _) => seriesData.color);
//     // if (seriesList == null) {
//     //   SmeupLogService.writeDebugMessage(
//     //       'error in colAxes or colSeries definition',
//     //       logType: LogType.error);
//     //   return SmeupNotAvailable();
//     // }

//     double? chartHeight = widget.height;
//     double? chartWidth = widget.width;
//     if (_model != null && _model!.parent != null) {
//       if (chartHeight == 0)
//         chartHeight = (_model!.parent as KenSectionModel).height;
//       if (chartWidth == 0)
//         chartWidth = (_model!.parent as KenSectionModel).width;
//     } else {
//       if (chartHeight == 0)
//         chartHeight = KenUtilities.getDeviceInfo().safeHeight;
//       if (chartWidth == 0) chartWidth = KenUtilities.getDeviceInfo().safeWidth;
//     }

//     return SizedBox(
//       height: chartHeight,
//       width: chartWidth,
//       child: charts.BarChart(
//         seriesList,
//         animate: false,
//         domainAxis: new charts.OrdinalAxisSpec(
//           showAxisLine: true,
//         ),
//         behaviors: widget.legend! ? [new charts.SeriesLegend()] : null,
//       ),
//     );
//   }

//   Widget _getPieChartComponent(KenChartDatasource _data) {
//     var seriesList = _getSeriesList(_data, _model, null);

//     double? chartHeight = widget.height;
//     double? chartWidth = widget.width;
//     if (_model != null && _model!.parent != null) {
//       if (chartHeight == 0)
//         chartHeight = (_model!.parent as KenSectionModel).height;
//       if (chartWidth == 0)
//         chartWidth = (_model!.parent as KenSectionModel).width;
//     } else {
//       if (chartHeight == 0)
//         chartHeight = KenUtilities.getDeviceInfo().safeHeight;
//       if (chartWidth == 0) chartWidth = KenUtilities.getDeviceInfo().safeWidth;
//     }

//     return SizedBox(
//       height: chartHeight,
//       width: chartWidth,
//       child: charts.PieChart(
//         seriesList,
//         animate: false,
//       ),
//     );
//   }

//   List<charts.Series<KenChartSeries, String>> _getSeriesList(
//       KenChartDatasource _data,
//       KenChartModel? _model,
//       charts.Color Function(KenChartSeries, int?)? getColor) {
//     int colAxes = -1;
//     int colSeries = -1;
//     int noAxes = 0;
//     int noSeries = 0;

//     var seriesList =
//         List<charts.Series<KenChartSeries, String>>.empty(growable: true);

//     // only 1 axes and at least 1 series
//     try {
//       noAxes = _data.columns!
//           .where((element) => element.type == ColumnType.Axes)
//           .length;
//       noSeries = _data.columns!
//           .where((element) => element.type == ColumnType.Series)
//           .length;
//     } catch (e) {
//       return seriesList;
//     }
//     if (noAxes != 1) {
//       return seriesList;
//     }
//     if (noSeries < 1) {
//       return seriesList;
//     }

//     try {
//       colAxes = _data.columns!
//           .indexWhere((element) => element.type == ColumnType.Axes);
//       colSeries = _data.columns!
//           .indexWhere((element) => element.type == ColumnType.Series);
//     } catch (e) {
//       return seriesList;
//     }

//     // colAxes or colSeries not specified
//     if (colAxes < 0 || colSeries < 0) {
//       return seriesList;
//     }

//     for (var i = 0; i < _data.columns!.length; i++) {
//       final column = _data.columns![i];
//       if (column.type != ColumnType.Series) continue;

//       var color = _getRandomColor(i);

//       var series = List<KenChartSeries>.empty(growable: true);

//       _data.rows!.forEach((row) {
//         String code = row.cells![colAxes] ?? '';
//         double value = KenUtilities.getDouble(row.cells![i]) ?? 0;
//         var graphSeries = KenChartSeries(code, value, color);
//         series.add(graphSeries);
//       });

//       seriesList.add(charts.Series<KenChartSeries, String>(
//         id: column.title!,
//         colorFn: getColor,
//         domainFn: (KenChartSeries seriesData, _) => seriesData.code,
//         measureFn: (KenChartSeries seriesData, _) => seriesData.value,
//         data: series,
//       ));
//     }

//     return seriesList;
//   }

//   dynamic _getRandomColor(index) {
//     Random random = Random();

//     return charts.Color(
//         a: 255,
//         r: random.nextInt(256),
//         g: random.nextInt(256),
//         b: random.nextInt(256));
//   }
}
