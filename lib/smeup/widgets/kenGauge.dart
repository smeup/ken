import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_gauge_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class KenGauge extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenGaugeModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  String? id;
  String? type;
  String? title;
  String? valueColName;
  String? warningColName;
  String? alertColName;
  String? maxColName;
  String? minColName;

  //dynamic data;
  double? minValue;
  double? maxValue;
  double? value;
  double? warning;
  double? alert;

  KenGauge(this.scaffoldKey, this.formKey,
      {this.value = KenGaugeModel.defaultValue,
      this.maxValue = KenGaugeModel.defaultMaxValue,
      this.minValue = KenGaugeModel.defaultMinValue,
      this.warning = KenGaugeModel.defaultWarning,
      this.alert = KenGaugeModel.defaultAlert,
      id = '',
      type = 'GAU',
      this.valueColName = KenGaugeModel.defaultValColName,
      this.maxColName = KenGaugeModel.defaultMaxColName,
      this.minColName = KenGaugeModel.defaultMinColName,
      this.warningColName = KenGaugeModel.defaultWarningColName,
      this.alertColName = KenGaugeModel.defaultAlertColName,
      this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  KenGauge.whitController(
      KenGaugeModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenGaugeModel m = model as KenGaugeModel;
    id = m.id;
    type = m.type;
    title = m.title;
    valueColName = m.valueColName;
    maxColName = m.maxColName;
    minColName = m.minColName;
    warningColName = m.warningColName;
    alertColName = m.alertColName;

    treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenGaugeModel m = model as KenGaugeModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).isNotEmpty) {
      value = KenUtilities.getDouble(workData['rows'][0][m.valueColName]);
      maxValue = KenUtilities.getDouble(workData['rows'][0][m.maxColName]);
      minValue = KenUtilities.getDouble(workData['rows'][0][m.minColName]);
      warning = KenUtilities.getDouble(workData['rows'][0][m.warningColName]);
      alert = KenUtilities.getDouble(workData['rows'][0][m.alertColName]);
    }
  }

  @override
  _KenGaugeState createState() => _KenGaugeState();
}

class _KenGaugeState extends State<KenGauge>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenGaugeModel? _model;
  double? _maxValue;
  double? _minValue;
  double? _value;
  double? _warning;
  double? _alert;

  @override
  void initState() {
    _model = widget.model;
    _value = widget.value;
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _warning = widget.warning;
    _alert = widget.alert;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final gauge = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.immediate;
        setDataLoad(widget.id, false);
      });
    });

    return gauge;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.delay) {
      if (_model != null) {
        // await SmeupGaugeDao.getData(_model!);
        await _model!.getData();
        widget.treatData(_model!);
        _value = widget.value;
        _maxValue = widget.maxValue;
        _minValue = widget.minValue;
        _warning = widget.warning;
        _alert = widget.alert;
      }
      setDataLoad(widget.id, true);
    }
    Widget children;

    double vMin = _minValue ?? 0;
    double vMax = _maxValue ?? 0;
    double vWar = _warning ?? 0;
    double vAle = _alert ?? 0;
    double vVal = _value ?? 0;

    children = Center(
      child: SfRadialGauge(
          title: const GaugeTitle(
              text: 'Speedometer',
              textStyle: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(6, 137, 155, 1))),
          axes: <RadialAxis>[
            RadialAxis(minimum: vMin, maximum: vMax, ranges: <GaugeRange>[
              GaugeRange(
                  startValue: vMin,
                  endValue: vWar,
                  color: const Color.fromRGBO(6, 137, 155, 1),
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: vWar,
                  endValue: vAle,
                  color: const Color.fromRGBO(223, 138, 4, 1),
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: vAle,
                  endValue: vMax,
                  color: Colors.red,
                  startWidth: 10,
                  endWidth: 10)
            ], pointers: <GaugePointer>[
              NeedlePointer(value: vVal)
            ], annotations: <GaugeAnnotation>[
              GaugeAnnotation(
                  widget: Text(vVal.toString(),
                      style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.red)),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ]),
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
