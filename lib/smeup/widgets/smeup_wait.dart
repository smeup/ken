import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_wait_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_progress_indicator.dart';
import 'smeup_splash.dart';

// ignore: must_be_immutable
class SmeupWait extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupWaitModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;
  String title;
  Color splashColor;
  Color loaderColor;
  Color circularTrackColor;

  SmeupWait(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.title = '',
      this.splashColor,
      this.loaderColor,
      this.circularTrackColor})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupWait.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupWaitModel m = model;
    id = m.id;
    type = m.type;
    splashColor = m.splashColor;
    loaderColor = m.loaderColor;
    title = m.title;
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupWaitModel m = model;

    // change data format
    return formatDataFields(m);
  }

  @override
  State<SmeupWait> createState() => _SmeupWaitState();
}

class _SmeupWaitState extends State<SmeupWait>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupWaitModel _model;

  @override
  void initState() {
    _model = widget.model;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget splash = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return splash;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    Widget children;

    children = Stack(
      children: [
        SmeupSplash(widget.scaffoldKey, widget.formKey,
            color: widget.splashColor,
            id: 'SmeupSplash_${widget.scaffoldKey.hashCode.toString()}'),
        SmeupProgressIndicator(this.widget.scaffoldKey, this.widget.formKey,
            color: widget.loaderColor,
            circularTrackColor: widget.circularTrackColor,
            id: 'SmeupProgressIndicator_${widget.scaffoldKey.hashCode.toString()}')
      ],
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
