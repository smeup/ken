import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_chart_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_char_series_data.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_column.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_series.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_datasource.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'dart:math';

// ignore: must_be_immutable
class SmeupChart extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupChartModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;
  String title;

  ChartType chartType;
  int refresh;

  SmeupChartDatasource data;

  SmeupChart(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'CHA',
      this.title = '',
      this.chartType = SmeupChartModel.defaultChartType,
      this.refresh = SmeupChartModel.defaultRefresh,
      this.data})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupChart.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }
  @override
  runControllerActivities(SmeupModel model) {
    SmeupChartModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    chartType = m.chartType;
    refresh = m.refresh;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupChartModel m = model;

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
  SmeupChartModel _model;
  SmeupChartDatasource _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
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
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupChartDao.getData(_model);
        _data = widget.treatData(_model);
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
      case ChartType.Area:
        children = _getAreaChartComponent(_data);
        break;
      case ChartType.Line:
        children = _getTimeChartComponent(_data);
        break;
      case ChartType.Bar:
        children = _getBarChartComponent(_data);
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

  Widget _getAreaChartComponent(SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList =
        List<charts.Series<SmeupChartSeriesData, double>>.empty(growable: true);

    seriesList.add(
      new charts.Series<SmeupChartSeriesData, double>(
        id: "firstGroup",
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SmeupChartSeriesData seriesData, _) => seriesData.x,
        measureFn: (SmeupChartSeriesData seriesData, _) => seriesData.y,
        data: getDataTable(0, 1, -1, null, null),
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    );

    seriesList.add(
      new charts.Series<SmeupChartSeriesData, double>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupChartSeriesData seriesData, _) => seriesData.x,
        measureFn: (SmeupChartSeriesData seriesData, _) => seriesData.y,
        data: getDataTable(0, 2, -1, null, null),
      ),
    );

    final chart =
        charts.LineChart(seriesList, animate: animate, customSeriesRenderers: [
      new charts.LineRendererConfig(
          // ID used to link series to this renderer.
          customRendererId: 'customArea',
          includeArea: true,
          stacked: true),
    ]);

    var container = Container(
      child: chart,
      width: 200,
      height: 200,
    );

    return container;
  }

  Widget _getTimeChartComponent(SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList = List<charts.Series<SmeupChartSeriesData, DateTime>>.empty(
        growable: true);

    seriesList.add(
      new charts.Series<SmeupChartSeriesData, DateTime>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupChartSeriesData seriesData, _) =>
            new DateTime.fromMillisecondsSinceEpoch(seriesData.x.truncate()),
        measureFn: (SmeupChartSeriesData seriesData, _) => seriesData.y,
        data: getDataTable(0, 1, -1, null, null),
      ),
    );

    final chart = charts.TimeSeriesChart(
      seriesList,
      animate: animate,
    );

    final container = Container(
      child: chart,
      width: 200,
      height: 200,
    );

    return container;
  }

  /// colAxes = the column which contains the X axes values
  /// colSeries = the column which contains the Y axes values
  Widget _getBarChartComponent(SmeupChartDatasource smeupChartDatasource) {
    int colAxes = -1;
    int colSeries = -1;
    int noAxes = 0;
    int noSeries = 0;

    // only 1 axes and at least 1 series
    try {
      noAxes = smeupChartDatasource.columns
          .where((element) => element.type == ColumnType.Axes)
          .length;
      noSeries = smeupChartDatasource.columns
          .where((element) => element.type == ColumnType.Series)
          .length;
    } catch (e) {
      return _getError('colAxes or colSeries error: $e');
    }
    if (noAxes != 1) {
      return _getError('there must be just one axes column');
    }
    if (noSeries < 1) {
      return _getError('there must be at least one series column');
    }

    try {
      colAxes = smeupChartDatasource.columns
          .indexWhere((element) => element.type == ColumnType.Axes);
      colSeries = smeupChartDatasource.columns
          .indexWhere((element) => element.type == ColumnType.Series);
    } catch (e) {
      return _getError('colAxes or colSeries not specified: $e');
    }

    // colAxes or colSeries not specified
    if (colAxes < 0 || colSeries < 0) {
      return _getError('colAxes or colSeries not found');
    }

    var seriesList =
        List<charts.Series<SmeupChartSeries, String>>.empty(growable: true);

    for (var i = 0; i < smeupChartDatasource.columns.length; i++) {
      final column = smeupChartDatasource.columns[i];
      if (column.type != ColumnType.Series) continue;

      var color = _getRandomColor(i);

      var series = List<SmeupChartSeries>.empty(growable: true);

      smeupChartDatasource.rows.forEach((row) {
        String code = row.cells[colAxes] ?? '';
        double value = SmeupUtilities.getDouble(row.cells[i]) ?? 0;
        var graphSeries = SmeupChartSeries(code, value, color);
        series.add(graphSeries);
      });

      seriesList.add(charts.Series<SmeupChartSeries, String>(
        id: 'Series',
        colorFn: (SmeupChartSeries seriesData, _) => seriesData.color,
        domainFn: (SmeupChartSeries seriesData, _) => seriesData.code,
        measureFn: (SmeupChartSeries seriesData, _) => seriesData.value,
        data: series,
      ));
    }

    return SizedBox(
      width: 400.0,
      height: 200.0,
      child: charts.BarChart(
        seriesList,
        animate: false,
        domainAxis: new charts.OrdinalAxisSpec(
          // Make sure that we draw the domain axis line.
          showAxisLine: true,
          // But don't draw anything else.
          // renderSpec: new charts.NoneRenderSpec()
        ),
      ),
    );
  }

  List<SmeupChartSeriesData> getDataTable(int xCol, int yCol, int filterCol,
      Function filterFunction, String filterValue) {
    List<SmeupChartSeriesData> seriesData;
    seriesData = List<SmeupChartSeriesData>.empty(growable: true);

    _data.rows.forEach((f) {
      double x = 0;
      if (f.cells[xCol] is double)
        x = f.cells[xCol];
      else
        x = double.parse(f.cells[xCol].toString());

      double y = 0;
      if (f.cells[yCol] is double)
        y = f.cells[yCol];
      else
        y = double.parse(f.cells[yCol].toString());

      String valueToTest;
      if (filterCol >= 0) valueToTest = f.cells[filterCol].toString();

      if (filterFunction == null ||
          filterCol >= 0 &&
              filterFunction != null &&
              filterFunction(valueToTest, filterValue))
        seriesData.add(SmeupChartSeriesData(x, y));
    });

    return seriesData;
  }

  Widget _getError(String message) {
    SmeupLogService.writeDebugMessage(message, logType: LogType.error);
    return SmeupNotAvailable();
  }

  dynamic _getRandomColor(index) {
    Random random = Random();

    // if (index == 1) {
    //   return charts.ColorUtil.fromDartColor(Colors.blue);
    // } else {
    //   return charts.ColorUtil.fromDartColor(Colors.red);
    // }

    return charts.Color(
        a: 255,
        r: random.nextInt(256),
        g: random.nextInt(256),
        b: random.nextInt(256));
  }
}
