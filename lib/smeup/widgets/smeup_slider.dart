import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_slider_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_slider_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupSlider extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;
  Function clientOnChange;
  SmeupSliderModel model;

  EdgeInsetsGeometry padding;
  double value;
  double sldMin;
  double sldMax;
  String id;
  String type;
  String title;

  SmeupSlider(this.scaffoldKey, this.formKey,
      {this.padding = SmeupSliderModel.defaultPadding,
      this.title,
      this.id = '',
      this.type = 'SLD',
      this.value = SmeupSliderModel.defaultValue,
      this.sldMax = SmeupSliderModel.defaultSldMax,
      this.sldMin = SmeupSliderModel.defaultSldMin})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupSlider.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupSliderModel m = model;
    id = m.id;
    type = m.type;
    value = m.value;
    sldMin = m.sldMin;
    sldMax = m.sldMax;
    title = m.title;
    padding = m.padding;

    value = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupSliderModel m = model;

    // change data format
    var workData = formatDataFields(m);

    if (workData != null) {
      double retValue = 0;
      var firstElement = (workData['rows'] as List).first;
      if (firstElement != null) {
        if (firstElement[m.optionsDefault['value']] != null) {
          retValue = SmeupUtilities.getDouble(
                  firstElement[m.optionsDefault['value']]) ??
              0;
        }
      }
      return retValue;
    }
  }

  @override
  _SmeupSliderState createState() => _SmeupSliderState();
}

class _SmeupSliderState extends State<SmeupSlider>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupSliderModel _model;
  dynamic _value;

  @override
  void initState() {
    _model = widget.model;
    _value = widget.value;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget slider = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return slider;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupSliderDao.getData(_model);
        _value = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_value == null) {
      return getFunErrorResponse(context, _model);
    }

    SmeupVariablesService.setVariable(widget.id, _value,
        formKey: widget.formKey);

    //final children = Divider(
    //sldMin: widget.sldMin,
    //sldMax: widget.sldMin,
    //);

    final children = Center(
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: Slider(
            key: ValueKey(widget.id),
            onChanged: (value) {
              if (widget.clientOnChange != null) widget.clientOnChange(value);
              SmeupVariablesService.setVariable(widget.id, value,
                  formKey: widget.formKey);
            },
            value: _value,
            onChangeEnd: widget.clientOnChange,
            min: widget.sldMin,
            max: widget.sldMax,
          )),
    );

    SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: LogType.error);

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
