import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_slider_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenSliderWidget.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenSlider extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  KenSliderModel? model;

  Color? activeTrackColor;
  Color? thumbColor;
  Color? inactiveTrackColor;
  EdgeInsetsGeometry? padding;
  double? value;
  double? sldMin;
  double? sldMax;
  String? id;
  int? divisions;
  String? type;
  String? title;
  String? label;
  Function? clientOnChange;
  late Function onChanged;

  Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenSlider(this.scaffoldKey, this.formKey,
      {this.activeTrackColor,
      this.thumbColor,
      this.inactiveTrackColor,
      this.padding = KenSliderModel.defaultPadding,
      this.title,
      this.id = '',
      this.label,
      this.divisions = 10,
      this.type = 'SLD',
      this.value = 0,
      this.sldMax = KenSliderModel.defaultSldMax,
      this.sldMin = KenSliderModel.defaultSldMin,
      this.clientOnChange,
      required this.onChanged,
      this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenSliderModel.setDefaults(this);
  }

  KenSlider.withController(
      KenSliderModel this.model, this.scaffoldKey, this.formKey, this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenSliderModel m = model as KenSliderModel;
    id = m.id;
    type = m.type;
    sldMin = m.sldMin;
    sldMax = m.sldMax;
    title = m.title;
    padding = m.padding;
    activeTrackColor = m.activeTrackColor;
    thumbColor = m.thumbColor;
    inactiveTrackColor = m.inactiveTrackColor;
    label = m.label;

    value = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenSliderModel m = model as KenSliderModel;

    // change data format
    var workData = formatDataFields(m);

    if (workData != null) {
      double retValue = 0;
      var firstElement = (workData['rows'] as List).first;
      if (firstElement != null) {
        if (firstElement['value'] != null) {
          retValue = KenUtilities.getDouble(firstElement['value']) ?? 0;
        }
      }
      return retValue;
    }
  }

  @override
  _KenSliderState createState() => _KenSliderState();
}

class _KenSliderState extends State<KenSlider>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenSliderModel? _model;
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupSliderDao.getData(_model!);
        await _model!.getData();
        _value = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_value == null) {
      return getFunErrorResponse(context, _model);
    }

    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.getChildren, null, null);
    }

    final children = Center(
      child: Container(
          padding: EdgeInsets.only(left: 10, right: 10),
          child: KenSliderWidget(
            widget.scaffoldKey,
            widget.formKey,
            //id: widget.id,
            activeTrackColor: widget.activeTrackColor,
            thumbColor: widget.thumbColor,
            inactiveTrackColor: widget.inactiveTrackColor,
            sldMax: widget.sldMax,
            sldMin: widget.sldMin,
            value: widget.value,
            divisions: widget.divisions,
            label: widget.label,
            onChanged: widget.onChanged,
            clientOnChange: (value) {
              _value = value;

              if (widget.callBack != null) {
                widget.callBack!(
                    widget, KenCallbackType.onClientChange, value, null);
              }
            },
          )),
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
