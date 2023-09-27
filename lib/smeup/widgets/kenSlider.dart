import 'package:flutter/material.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_slider_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenSliderWidget.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

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
  Function? onChanged;

  KenSlider(
    this.scaffoldKey,
    this.formKey, {
    this.activeTrackColor = KenSliderModel.defaultActiveTrackColor,
    this.thumbColor = KenSliderModel.defaultThumbColor,
    this.inactiveTrackColor = KenSliderModel.defaultInactiveTrackColor,
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
    this.onChanged,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  KenSlider.withController(
    KenSliderModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
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

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenSliderGetChildren,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: null),
    );

    final children = Center(
      child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
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
            onChanged: widget.onChanged ?? () {},
            clientOnChange: (value) {
              _value = value;

              KenMessageBus.instance.publishRequest(
                widget.globallyUniqueId,
                KenTopic.kenSliderOnClientChange,
                KenMessageBusEventData(
                    context: context,
                    widget: widget,
                    model: _model,
                    data: value),
              );
            },
          )),
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
