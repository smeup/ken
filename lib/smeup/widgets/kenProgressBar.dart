import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_progress_bar_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

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
  double? bordeRadius;

  double? data;

  Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenProgressBar.withController(KenProgressBarModel this.model,
      this.scaffoldKey, this.formKey, this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenProgressBar(this.scaffoldKey, this.formKey,
      {this.color,
      this.linearTrackColor,
      this.id = '',
      this.type = 'FLD',
      this.valueField = KenProgressBarModel.defaultValueField,
      this.title = '',
      this.height = KenProgressBarModel.defaultHeight,
      this.data = 0,
      this.padding = KenProgressBarModel.defaultPadding,
      this.progressBarMinimun = KenProgressBarModel.defaultProgressBarMinimun,
      this.progressBarMaximun = KenProgressBarModel.defaultProgressBarMaximun,
      this.bordeRadius = KenProgressBarModel.defaultBorderRadius,
      this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenProgressBarModel.setDefaults(this);
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
    bordeRadius = m.bordeRadius;
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
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return pgb;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    Widget children;

    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupProgressBarDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    widget.callBack!(widget, KenCallbackType.getChildren, _data, null);

    children = Center(
      child: Container(
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
