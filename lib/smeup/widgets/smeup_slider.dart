import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_slider_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_slider_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_slider_widget.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

import '../services/smeup_dynamism_service.dart';

// ignore: must_be_immutable
class SmeupSlider extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  SmeupSliderModel? model;

  Color? activeTrackColor;
  Color? thumbColor;
  Color? inactiveTrackColor;
  EdgeInsetsGeometry? padding;
  double? value;
  double? sldMin;
  double? sldMax;
  String? id;
  String? type;
  String? title;
  Function? clientOnChange;

  SmeupSlider(this.scaffoldKey, this.formKey,
      {this.activeTrackColor,
      this.thumbColor,
      this.inactiveTrackColor,
      this.padding = SmeupSliderModel.defaultPadding,
      this.title,
      this.id = '',
      this.type = 'SLD',
      this.value = 0,
      this.sldMax = SmeupSliderModel.defaultSldMax,
      this.sldMin = SmeupSliderModel.defaultSldMin,
      this.clientOnChange})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupSliderModel.setDefaults(this);
  }

  SmeupSlider.withController(
    SmeupSliderModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupSliderModel m = model as SmeupSliderModel;
    id = m.id;
    type = m.type;
    sldMin = m.sldMin;
    sldMax = m.sldMax;
    title = m.title;
    padding = m.padding;
    activeTrackColor = m.activeTrackColor;
    thumbColor = m.thumbColor;
    inactiveTrackColor = m.inactiveTrackColor;

    value = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupSliderModel m = model as SmeupSliderModel;

    // change data format
    var workData = formatDataFields(m);

    if (workData != null) {
      double retValue = 0;
      var firstElement = (workData['rows'] as List).first;
      if (firstElement != null) {
        if (firstElement['value'] != null) {
          retValue = SmeupUtilities.getDouble(firstElement['value']) ?? 0;
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
  SmeupSliderModel? _model;
  dynamic _value;

  @override
  void initState() {
    _model = widget.model;
    _value = widget.value;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
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
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupSliderDao.getData(_model!);
        _value = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_value == null) {
      return getFunErrorResponse(context, _model);
    }

    SmeupVariablesService.setVariable(widget.id, _value,
        formKey: widget.formKey);

    final children = Center(
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: SmeupSliderWidget(
            widget.scaffoldKey,
            widget.formKey,
            //id: widget.id,
            activeTrackColor: widget.activeTrackColor,
            thumbColor: widget.thumbColor,
            inactiveTrackColor: widget.inactiveTrackColor,
            sldMax: widget.sldMax,
            sldMin: widget.sldMin,
            value: _value,
            clientOnChange: (value) {
              _value = value;
              SmeupVariablesService.setVariable(widget.id, value,
                  formKey: widget.formKey);
              if (widget.clientOnChange != null) {
                widget.clientOnChange!(value);
              }
              if (_model != null) {
                SmeupDynamismService.run(_model!.dynamisms, context, 'change',
                    widget.scaffoldKey, widget.formKey);
              }
            },
          )),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
