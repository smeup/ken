import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_model.dart';
import 'package:mobile_components_library/smeup/models/smeup_graph_model.dart';
import 'package:mobile_components_library/smeup/models/smeupChartDatasource.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_service_response.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SmeupChart extends StatefulWidget {
  final SmeupChartModel smeupChartModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupChart(this.smeupChartModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupChartState createState() => _SmeupChartState();
}

class _SmeupChartState extends State<SmeupChart> with SmeupWidgetStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chart = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getChartComponent(widget.smeupChartModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupChartModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupChart: ${snapshot.error}',
                logType: LogType.error);
            notifyError(context, widget.smeupChartModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return Center(child: snapshot.data.children);
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
    //     widget.smeupChartModel.id, widget.smeupChartModel.type, notifier);
    return chart;
  }

  Future<SmeupWidgetBuilderResponse> _getChartComponent(
      SmeupChartModel smeupChartModel) async {
    var children;

    SmeupServiceResponse smeupServiceResponse;
    if (smeupChartModel.smeupFun.isFunValid()) {
      smeupServiceResponse =
          await SmeupDataService.invoke(smeupChartModel.smeupFun);

      if (!smeupServiceResponse.succeded)
        return SmeupWidgetBuilderResponse(smeupChartModel,
            new Text(smeupServiceResponse.result.data.toString()));
    }

    var smeupChartDatasource;

    smeupChartDatasource = SmeupChartDatasource.fromMap(
        smeupChartModel, smeupServiceResponse.result.data);

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
        children =
            _getAreaChartComponent(smeupChartModel, smeupChartDatasource);
        break;
      case 'Line':
        children =
            _getTimeChartComponent(smeupChartModel, smeupChartDatasource);
        break;
      case 'Line':
        children = _getBarChartComponent(smeupChartModel, smeupChartDatasource);
        break;
      default:
        SmeupLogService.writeDebugMessage(
            'Error SmeupChart charttype not available',
            logType: LogType.error);
        children = SmeupNotAvailable();
    }

    children = _getBarChartComponent(smeupChartModel, smeupChartDatasource);

    return SmeupWidgetBuilderResponse(smeupChartModel, children);
  }

  Widget _getAreaChartComponent(SmeupChartModel smeupChartModel,
      SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList =
        List<charts.Series<SmeupGraphData, double>>.empty(growable: true);

    seriesList.add(
      new charts.Series<SmeupGraphData, double>(
        id: "firstGroup",
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SmeupGraphData sales, _) => sales.x,
        measureFn: (SmeupGraphData sales, _) => sales.y,
        //data: smeupChartDatasource.getDataTable(0, 1, (k, z) { return k == z;}, '1'),
        data: smeupChartDatasource.getDataTable(0, 1, -1, null, null),
      )..setAttribute(charts.rendererIdKey, 'customArea'),
    );

    seriesList.add(
      new charts.Series<SmeupGraphData, double>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupGraphData sales, _) => sales.x,
        measureFn: (SmeupGraphData sales, _) => sales.y,
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

  Widget _getTimeChartComponent(SmeupChartModel smeupChartModel,
      SmeupChartDatasource smeupChartDatasource) {
    bool animate = true;

    var seriesList =
        List<charts.Series<SmeupGraphData, DateTime>>.empty(growable: true);

    seriesList.add(
      new charts.Series<SmeupGraphData, DateTime>(
        id: "secondGRoup",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (SmeupGraphData sales, _) =>
            new DateTime.fromMillisecondsSinceEpoch(sales.x.truncate()),
        measureFn: (SmeupGraphData sales, _) => sales.y,
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

  Widget _getBarChartComponent(SmeupChartModel smeupChartModel,
      SmeupChartDatasource smeupChartDatasource) {
    var graphModelList = List<SmeupGraphModel>.empty(growable: true);

    int colAxes = smeupChartDatasource.columns
        .indexWhere((element) => element.fill == 'ASSE');
    int colSeries = smeupChartDatasource.columns
        .indexWhere((element) => element.fill == 'SERIE');

    smeupChartDatasource.rows.forEach((weekBooking) {
      String code = weekBooking.cells[colAxes] ?? '';
      int value = int.parse(weekBooking.cells[colSeries].trim()) ?? 0;

      var graphModel = SmeupGraphModel(code, value);
      graphModelList.add(graphModel);
    });

    final serie = [
      new charts.Series<SmeupGraphModel, String>(
        id: 'Persone',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (SmeupGraphModel booking, _) => booking.code,
        measureFn: (SmeupGraphModel booking, _) => booking.value,
        data: graphModelList,
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
