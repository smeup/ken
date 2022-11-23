import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_chart_column.dart';
import 'package:ken/smeup/models/widgets/ken_chart_series.dart';
import 'package:ken/smeup/models/widgets/ken_chart_datasource.dart';
import 'package:ken/smeup/models/widgets/ken_chart_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/ken_not_available.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:ken/smeup/widgets/ken_widget_state_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_state_mixin.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

// ignore: must_be_immutable
class KenChart extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenChartModel? model;
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
      this.chartType = KenChartModel.defaultChartType,
      this.refresh = KenChartModel.defaultRefresh,
      this.height = KenChartModel.defaultHeight,
      this.width = KenChartModel.defaultWidth,
      this.legend = KenChartModel.defaultLegend,
      this.data})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  KenChart.withController(
      KenChartModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }
  @override
  runControllerActivities(KenModel model) {
    KenChartModel m = model as KenChartModel;
    id = m.id;
    type = m.type;
    title = m.title;
    chartType = m.chartType;
    //refresh = m.refresh;
    width = m.width;
    height = m.height;
    legend = m.legend;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenChartModel m = model as KenChartModel;

    // change data format
    var workData = formatDataFields(m);

    final smeupChartDatasource = KenChartDatasource.fromMap(workData);
    return smeupChartDatasource;
  }

  @override
  _KenChartState createState() => _KenChartState();
}

class _KenChartState extends State<KenChart>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenChartModel? _model;
  KenChartDatasource? _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chart = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return chart;
  }

  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {

        // await SmeupChartDao.getData(_model!);
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    var children;

    // TODOO: refresh
    // if(_model.refreshMilliseconds > 0)
    // {
    //   var duration = Duration(milliseconds: smeupChartDatasource.refreshMilliseconds);
    //   new Timer.periodic(duration, (Timer t) async =>
    //     response = await smeupHttpService.getScript(smeupChartDatasource.fun)
    //   );
    // }

    switch (widget.chartType) {
      case ChartType.Bar:
        children = _getBarChartComponent(_data!);
        break;
      case ChartType.Pie:
        children = _getPieChartComponent(_data!);
        break;
      default:
        KenLogService.writeDebugMessage(
            'Error SmeupChart charttype not available',
            logType: KenLogType.error);
        children = KenNotAvailable();
    }

    //children = _getBarChartComponent(_data);

    return KenWidgetBuilderResponse(_model, children);
  }

  /// colAxes = the column which contains the X axes values
  /// colSeries = the column which contains the Y axes values
  Widget _getBarChartComponent(KenChartDatasource _data) {
    var seriesList = _getSeriesList(
        _data, _model, (KenChartSeries seriesData, _) => seriesData.color);
    // if (seriesList == null) {
    //   SmeupLogService.writeDebugMessage(
    //       'error in colAxes or colSeries definition',
    //       logType: LogType.error);
    //   return SmeupNotAvailable();
    // }

    double? chartHeight = widget.height;
    double? chartWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (chartHeight == 0)
        chartHeight = (_model!.parent as KenSectionModel).height;
      if (chartWidth == 0)
        chartWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (chartHeight == 0)
        chartHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (chartWidth == 0)
        chartWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    return SizedBox(
      height: chartHeight,
      width: chartWidth,
      child: charts.BarChart(
        seriesList,
        animate: false,
        domainAxis: new charts.OrdinalAxisSpec(
          showAxisLine: true,
        ),
        behaviors: widget.legend! ? [new charts.SeriesLegend()] : null,
      ),
    );
  }

  Widget _getPieChartComponent(KenChartDatasource _data) {
    var seriesList = _getSeriesList(_data, _model, null);

    double? chartHeight = widget.height;
    double? chartWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (chartHeight == 0)
        chartHeight = (_model!.parent as KenSectionModel).height;
      if (chartWidth == 0)
        chartWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (chartHeight == 0)
        chartHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (chartWidth == 0)
        chartWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    return SizedBox(
      height: chartHeight,
      width: chartWidth,
      child: charts.PieChart(
        seriesList,
        animate: false,
      ),
    );
  }

  List<charts.Series<KenChartSeries, String>> _getSeriesList(
      KenChartDatasource _data,
      KenChartModel? _model,
      charts.Color Function(KenChartSeries, int?)? getColor) {
    int colAxes = -1;
    int colSeries = -1;
    int noAxes = 0;
    int noSeries = 0;

    var seriesList =
        List<charts.Series<KenChartSeries, String>>.empty(growable: true);

    // only 1 axes and at least 1 series
    try {
      noAxes = _data.columns!
          .where((element) => element.type == ColumnType.Axes)
          .length;
      noSeries = _data.columns!
          .where((element) => element.type == ColumnType.Series)
          .length;
    } catch (e) {
      return seriesList;
    }
    if (noAxes != 1) {
      return seriesList;
    }
    if (noSeries < 1) {
      return seriesList;
    }

    try {
      colAxes = _data.columns!
          .indexWhere((element) => element.type == ColumnType.Axes);
      colSeries = _data.columns!
          .indexWhere((element) => element.type == ColumnType.Series);
    } catch (e) {
      return seriesList;
    }

    // colAxes or colSeries not specified
    if (colAxes < 0 || colSeries < 0) {
      return seriesList;
    }

    for (var i = 0; i < _data.columns!.length; i++) {
      final column = _data.columns![i];
      if (column.type != ColumnType.Series) continue;

      var color = _getRandomColor(i);

      var series = List<KenChartSeries>.empty(growable: true);

      _data.rows!.forEach((row) {
        String code = row.cells![colAxes] ?? '';
        double value = KenUtilities.getDouble(row.cells![i]) ?? 0;
        var graphSeries = KenChartSeries(code, value, color);
        series.add(graphSeries);
      });

      seriesList.add(charts.Series<KenChartSeries, String>(
        id: column.title!,
        colorFn: getColor,
        domainFn: (KenChartSeries seriesData, _) => seriesData.code,
        measureFn: (KenChartSeries seriesData, _) => seriesData.value,
        data: series,
      ));
    }

    return seriesList;
  }

  dynamic _getRandomColor(index) {
    Random random = Random();

    return charts.Color(
        a: 255,
        r: random.nextInt(256),
        g: random.nextInt(256),
        b: random.nextInt(256));
  }
}