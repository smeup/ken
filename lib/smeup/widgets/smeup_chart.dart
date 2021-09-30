import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_chart_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_char_series_data.dart';
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
  dynamic data;

  SmeupChart(this.scaffoldKey, this.formKey,
      {this.id = '', this.type = 'CHA', this.title = ''})
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

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupChartModel m = model;

    // change data format
    return formatDataFields(m);
  }

  @override
  _SmeupChartState createState() => _SmeupChartState();
}

class _SmeupChartState extends State<SmeupChart>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupChartModel _model;
  dynamic _data;

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
    var smeupChartDatasource;

    smeupChartDatasource = SmeupChartDatasource.fromMap(_model, _data);

    // TODOO: refresh
    // if(smeupChartDatasource.refreshMilliseconds > 0)
    // {
    //   var duration = Duration(milliseconds: smeupChartDatasource.refreshMilliseconds);
    //   new Timer.periodic(duration, (Timer t) async =>
    //     response = await smeupHttpService.getScript(smeupChartDatasource.fun)
    //   );
    // }

    switch (smeupChartDatasource.chartType) {
      case 'Area':
        children = _getAreaChartComponent(smeupChartDatasource);
        break;
      case 'Line':
        children = _getTimeChartComponent(smeupChartDatasource);
        break;
      case 'Line':
        children = _getBarChartComponent(smeupChartDatasource);
        break;
      default:
        SmeupLogService.writeDebugMessage(
            'Error SmeupChart charttype not available',
            logType: LogType.error);
        children = SmeupNotAvailable();
    }

    children = _getBarChartComponent(smeupChartDatasource);

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
        //data: smeupChartDatasource.getDataTable(0, 1, (k, z) { return k == z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 1, -1, null, null),
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    );

    seriesList.add(
      new charts.Series<SmeupChartSeriesData, double>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupChartSeriesData seriesData, _) => seriesData.x,
        measureFn: (SmeupChartSeriesData seriesData, _) => seriesData.y,
        //data: smeupChartDatasource.getDataTable((k, z) { return k != z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 2, -1, null, null),
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
        //data: smeupChartDatasource.getDataTable((k, z) { return k != z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 1, -1, null, null),
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

  Widget _getBarChartComponent(SmeupChartDatasource smeupChartDatasource) {
    var graphSeriesList = List<SmeupChartSeries>.empty(growable: true);

    int colAxes = smeupChartDatasource.columns
        .indexWhere((element) => element.fill == 'ASSE');
    int colSeries = smeupChartDatasource.columns
        .indexWhere((element) => element.fill == 'SERIE');

    smeupChartDatasource.rows.forEach((weekBooking) {
      String code = weekBooking.cells[colAxes] ?? '';
      int value = int.parse(weekBooking.cells[colSeries].trim()) ?? 0;

      var graphSeries = SmeupChartSeries(code, value);
      graphSeriesList.add(graphSeries);
    });

    final serie = [
      new charts.Series<SmeupChartSeries, String>(
        id: 'Persone',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SmeupChartSeries booking, _) => booking.code,
        measureFn: (SmeupChartSeries booking, _) => booking.value,
        data: graphSeriesList,
      )
    ];

    return SizedBox(
      width: 400.0,
      height: 200.0,
      child: charts.BarChart(
        serie,
        animate: false,
        domainAxis: new charts.OrdinalAxisSpec(
            // Make sure that we draw the domain axis line.
            showAxisLine: true,
            // But don't draw anything else.
            renderSpec: new charts.NoneRenderSpec()),
      ),
    );
  }
}
