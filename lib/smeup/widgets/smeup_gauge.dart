import 'package:flutter/material.dart';
import 'package:flutter_speedometer/flutter_speedometer.dart';
import 'package:mobile_components_library/smeup/daos/smeup_gauge_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_gauge_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupGauge extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupGaugeModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;
  String title;
  String valueColName;
  String warningColName;
  String maxColName;
  String minColName;

  //dynamic data;
  int minValue;
  int maxValue;
  int value;
  int warning;

  SmeupGauge(this.scaffoldKey, this.formKey,
      {this.value = SmeupGaugeModel.defaultValue,
      this.maxValue = SmeupGaugeModel.defaultMaxValue,
      this.minValue = SmeupGaugeModel.defaultMinValue,
      this.warning = SmeupGaugeModel.defaultWarning,
      id = '',
      type = 'GAU',
      this.valueColName = SmeupGaugeModel.defaultValColName,
      this.maxColName = SmeupGaugeModel.defaultMaxColName,
      this.minColName = SmeupGaugeModel.defaultMinColName,
      this.warningColName = SmeupGaugeModel.defaultWarningColName,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupGauge.whitController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupGaugeModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    valueColName = m.valueColName;
    maxColName = m.maxColName;
    minColName = m.minColName;
    warningColName = m.warningColName;

    treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupGaugeModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).length > 0) {
      value = workData['rows'][0][m.valueColName];
      maxValue = workData['rows'][0][m.maxColName];
      minValue = workData['rows'][0][m.minColName];
      warning = workData['rows'][0][m.warningColName];
    }
  }

  @override
  _SmeupGaugeState createState() => _SmeupGaugeState();
}

class _SmeupGaugeState extends State<SmeupGauge>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupGaugeModel _model;
  int _maxValue;
  int _minValue;
  int _value;
  int _warning;

  @override
  void initState() {
    _model = widget.model;
    _value = widget.value;
    _maxValue = widget.maxValue;
    _minValue = widget.minValue;
    _warning = widget.warning;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
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
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupGaugeDao.getData(_model);
        widget.treatData(_model);
        _value = widget.value;
        _maxValue = widget.maxValue;
        _minValue = widget.minValue;
        _warning = widget.warning;
      }
      setDataLoad(widget.id, true);
    }
    Widget children;

    //int maxValue = int.parse(_data['Elemento']['Max']);
    //int value = int.parse(_data['Elemento']['Valore']);
    //int warning = int.parse(_data['Elemento']['Soglia1']);

    children = Center(
      child: Speedometer(
        size: 100,
        minValue: _minValue,
        maxValue: _maxValue,
        currentValue: _value,
        warningValue: _warning,
        backgroundColor: Colors.white,
        meterColor: Colors.green,
        warningColor: Colors.red,
        kimColor: Colors.grey,
        displayNumericStyle: const TextStyle(
            fontFamily: 'Digital-Display', color: Colors.black, fontSize: 30),
        displayText: '',
        displayTextStyle: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
