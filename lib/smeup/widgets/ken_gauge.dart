import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';

class KenGauge extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  final String? id;
  final String? type;
  final String? title;
  final String? valueColName;
  final String? warningColName;
  final String? alertColName;
  final String? maxColName;
  final String? minColName;

  //dynamic data;
  final double? minValue;
  final double? maxValue;
  final double? value;
  final double? warning;
  final double? alert;

  const KenGauge(this.scaffoldKey, this.formKey,
      {super.key,
      this.value = KenGaugeDefaults.defaultValue,
      this.maxValue = KenGaugeDefaults.defaultMaxValue,
      this.minValue = KenGaugeDefaults.defaultMinValue,
      this.warning = KenGaugeDefaults.defaultWarning,
      this.alert = KenGaugeDefaults.defaultAlert,
      this.id = '',
      this.type = 'GAU',
      this.valueColName = KenGaugeDefaults.defaultValColName,
      this.maxColName = KenGaugeDefaults.defaultMaxColName,
      this.minColName = KenGaugeDefaults.defaultMinColName,
      this.warningColName = KenGaugeDefaults.defaultWarningColName,
      this.alertColName = KenGaugeDefaults.defaultAlertColName,
      this.title = ''});

  @override
  KenGaugeState createState() => KenGaugeState();
}

class KenGaugeState extends State<KenGauge> {
  double? _maxValue;
  double? _minValue;
  double? _value;
  double? _warning;
  double? _alert;

  @override
  void initState() {
    _value = widget.value;
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _warning = widget.warning;
    _alert = widget.alert;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double vMin = _minValue ?? 0;
    double vMax = _maxValue ?? 0;
    double vWar = _warning ?? 0;
    double vAle = _alert ?? 0;
    double vVal = _value ?? 0;

    final gauge = Center(
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

    return gauge;
  }
}
