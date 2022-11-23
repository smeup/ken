import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_progress_indicator_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupProgressIndicator extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupProgressIndicatorModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  Color? circularTrackColor;
  String? title;
  String? id;
  String? type;
  double? size;

  SmeupProgressIndicator.withController(
    SmeupProgressIndicatorModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupProgressIndicator(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.color,
      this.circularTrackColor,
      this.size = SmeupProgressIndicatorModel.defaultSize,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupProgressIndicatorModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupProgressIndicatorModel m = model as SmeupProgressIndicatorModel;
    id = m.id;
    type = m.type;
    color = m.color;
    circularTrackColor = m.circularTrackColor;
    title = m.title;
    size = m.size;
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupProgressIndicatorModel m = model as SmeupProgressIndicatorModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  State<SmeupProgressIndicator> createState() => _SmeupProgressIndicatorState();
}

class _SmeupProgressIndicatorState extends State<SmeupProgressIndicator>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupProgressIndicatorModel? _model;

  @override
  void initState() {
    _model = widget.model;
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
    Widget pgi = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return pgi;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    Widget children;

    children = Center(
      child: SizedBox(
        height: widget.size,
        width: widget.size,
        child: CircularProgressIndicator(
          color: widget.color,
          backgroundColor: widget.circularTrackColor,
        ),
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
