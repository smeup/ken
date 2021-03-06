import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_chart_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_column.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_series.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_datasource.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

// ignore: must_be_immutable
class SmeupChart extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupChartModel? model;
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

  SmeupChartDatasource? data;

  SmeupChart(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CHA',
      this.title = '',
      this.chartType = SmeupChartModel.defaultChartType,
      this.refresh = SmeupChartModel.defaultRefresh,
      this.height = SmeupChartModel.defaultHeight,
      this.width = SmeupChartModel.defaultWidth,
      this.legend = SmeupChartModel.defaultLegend,
      this.data})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupChart.withController(
      SmeupChartModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }
  @override
  runControllerActivities(SmeupModel model) {
    SmeupChartModel m = model as SmeupChartModel;
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
  dynamic treatData(SmeupModel model) {
    SmeupChartModel m = model as SmeupChartModel;

    // change data format
    var workData = formatDataFields(m);

    final smeupChartDatasource = SmeupChartDatasource.fromMap(workData);
    return smeupChartDatasource;
  }

  @override
  _SmeupChartState createState() => _SmeupChartState();
}

class _SmeupChartState extends State<SmeupChart>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupChartModel? _model;
  SmeupChartDatasource? _data;

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

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupChartDao.getData(_model!);
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
        SmeupLogService.writeDebugMessage(
            'Error SmeupChart charttype not available',
            logType: LogType.error);
        children = SmeupNotAvailable();
    }

    //children = _getBarChartComponent(_data);

    return SmeupWidgetBuilderResponse(_model, children);
  }

  /// colAxes = the column which contains the X axes values
  /// colSeries = the column which contains the Y axes values
  Widget _getBarChartComponent(SmeupChartDatasource _data) {
    var seriesList = _getSeriesList(
        _data, _model, (SmeupChartSeries seriesData, _) => seriesData.color);
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
        chartHeight = (_model!.parent as SmeupSectionModel).height;
      if (chartWidth == 0)
        chartWidth = (_model!.parent as SmeupSectionModel).width;
    } else {
      if (chartHeight == 0)
        chartHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      if (chartWidth == 0)
        chartWidth = SmeupUtilities.getDeviceInfo().safeWidth;
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

  Widget _getPieChartComponent(SmeupChartDatasource _data) {
    var seriesList = _getSeriesList(_data, _model, null);

    double? chartHeight = widget.height;
    double? chartWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (chartHeight == 0)
        chartHeight = (_model!.parent as SmeupSectionModel).height;
      if (chartWidth == 0)
        chartWidth = (_model!.parent as SmeupSectionModel).width;
    } else {
      if (chartHeight == 0)
        chartHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      if (chartWidth == 0)
        chartWidth = SmeupUtilities.getDeviceInfo().safeWidth;
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

  List<charts.Series<SmeupChartSeries, String>> _getSeriesList(
      SmeupChartDatasource _data,
      SmeupChartModel? _model,
      charts.Color Function(SmeupChartSeries, int?)? getColor) {
    int colAxes = -1;
    int colSeries = -1;
    int noAxes = 0;
    int noSeries = 0;

    var seriesList =
        List<charts.Series<SmeupChartSeries, String>>.empty(growable: true);

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

      var series = List<SmeupChartSeries>.empty(growable: true);

      _data.rows!.forEach((row) {
        String code = row.cells![colAxes] ?? '';
        double value = SmeupUtilities.getDouble(row.cells![i]) ?? 0;
        var graphSeries = SmeupChartSeries(code, value, color);
        series.add(graphSeries);
      });

      seriesList.add(charts.Series<SmeupChartSeries, String>(
        id: column.title!,
        colorFn: getColor,
        domainFn: (SmeupChartSeries seriesData, _) => seriesData.code,
        measureFn: (SmeupChartSeries seriesData, _) => seriesData.value,
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
