import 'package:flutter/material.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_progress_bar_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenProgressBar extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenProgressBarModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  Color? linearTrackColor;
  String? title;
  String? id;
  String? type;
  String? valueField;
  double? progressBarMinimun;
  double? progressBarMaximun;
  double? height;
  EdgeInsetsGeometry? padding;
  double? borderRadius;

  double? data;

  KenProgressBar.withController(
    KenProgressBarModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenProgressBar(
    this.scaffoldKey,
    this.formKey, {
    this.color = KenProgressBarModel.defaultColor,
    this.linearTrackColor = KenProgressBarModel.defaultLinearTrackColor,
    this.id = '',
    this.type = 'FLD',
    this.valueField = KenProgressBarModel.defaultValueField,
    this.title = '',
    this.height = KenProgressBarModel.defaultHeight,
    this.data = 0,
    this.padding = KenProgressBarModel.defaultPadding,
    this.progressBarMinimun = KenProgressBarModel.defaultProgressBarMinimun,
    this.progressBarMaximun = KenProgressBarModel.defaultProgressBarMaximun,
    this.borderRadius = KenProgressBarModel.defaultBorderRadius,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenProgressBarModel m = model as KenProgressBarModel;
    id = m.id;
    type = m.type;
    color = m.color;
    linearTrackColor = m.linearTrackColor;
    title = m.title;
    valueField = m.valueField;
    progressBarMinimun = m.progressBarMinimun;
    progressBarMaximun = m.progressBarMaximun;
    borderRadius = m.borderRadius;
    height = m.height;
    padding = m.padding;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenProgressBarModel m = model as KenProgressBarModel;

    return KenUtilities.getDouble(m.data['rows'][0][m.valueField]);
  }

  @override
  _KenProgressBarState createState() => _KenProgressBarState();
}

class _KenProgressBarState extends State<KenProgressBar>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenProgressBarModel? _model;
  double? _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget pgb = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.immediate;
        setDataLoad(widget.id, false);
      });
    });

    return pgb;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    Widget children;

    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.delay) {
      if (_model != null) {
        // await SmeupProgressBarDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenProgressBarGetChildren,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );

    children = Center(
      child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(widget.borderRadius!)),
          padding: widget.padding,
          child: LinearProgressIndicator(
            color: widget.color,
            backgroundColor: widget.linearTrackColor,
            minHeight: widget.height,
            key: ValueKey(widget.id),
            value: widget.progressBarMaximun == 0
                ? 0
                : _data! / widget.progressBarMaximun!,
          )),
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
