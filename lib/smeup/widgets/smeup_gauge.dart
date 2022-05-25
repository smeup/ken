import 'package:flutter/material.dart';
//import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:ken/smeup/daos/smeup_gauge_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_gauge_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';

// ignore: must_be_immutable
class SmeupGauge extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupGaugeModel? model;
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

  SmeupGauge(this.scaffoldKey, this.formKey,
      {this.value = SmeupGaugeModel.defaultValue,
      this.maxValue = SmeupGaugeModel.defaultMaxValue,
      this.minValue = SmeupGaugeModel.defaultMinValue,
      this.warning = SmeupGaugeModel.defaultWarning,
      this.alert = SmeupGaugeModel.defaultAlert,
      id = '',
      type = 'GAU',
      this.valueColName = SmeupGaugeModel.defaultValColName,
      this.maxColName = SmeupGaugeModel.defaultMaxColName,
      this.minColName = SmeupGaugeModel.defaultMinColName,
      this.warningColName = SmeupGaugeModel.defaultWarningColName,
      this.alertColName = SmeupGaugeModel.defaultAlertColName,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupGauge.whitController(
      SmeupGaugeModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupGaugeModel m = model as SmeupGaugeModel;
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
  dynamic treatData(SmeupModel model) {
    SmeupGaugeModel m = model as SmeupGaugeModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).length > 0) {
      value = SmeupUtilities.getDouble(workData['rows'][0][m.valueColName]);
      maxValue = SmeupUtilities.getDouble(workData['rows'][0][m.maxColName]);
      minValue = SmeupUtilities.getDouble(workData['rows'][0][m.minColName]);
      warning = SmeupUtilities.getDouble(workData['rows'][0][m.warningColName]);
      alert = SmeupUtilities.getDouble(workData['rows'][0][m.alertColName]);
    }
  }

  @override
  _SmeupGaugeState createState() => _SmeupGaugeState();
}

class _SmeupGaugeState extends State<SmeupGauge>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupGaugeModel? _model;
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
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return gauge;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupGaugeDao.getData(_model!);
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
          title: GaugeTitle(
              text: 'Speedometer',
              textStyle: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(6, 137, 155, 1))),
          axes: <RadialAxis>[
            RadialAxis(minimum: vMin, maximum: vMax, ranges: <GaugeRange>[
              GaugeRange(
                  startValue: vMin,
                  endValue: vWar,
                  color: Color.fromRGBO(6, 137, 155, 1),
                  startWidth: 10,
                  endWidth: 10),
              GaugeRange(
                  startValue: vWar,
                  endValue: vAle,
                  color: Color.fromRGBO(223, 138, 4, 1),
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
                  widget: Container(
                      child: Text(vVal.toString(),
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Colors.red))),
                  angle: 90,
                  positionFactor: 0.5)
            ])
          ]),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
