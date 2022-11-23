import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_splash_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupSplash extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupSplashModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  String? id;
  String? type;
  String? title;

  SmeupSplash(this.scaffoldKey, this.formKey,
      {this.id = '', this.type = 'FLD', this.color, this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupSplashModel.setDefaults(this);
  }

  SmeupSplash.withController(
    SmeupSplashModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupSplashModel m = model as SmeupSplashModel;
    id = m.id;
    type = m.type;
    color = m.color;
    title = m.title;
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupSplashModel m = model as SmeupSplashModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  State<SmeupSplash> createState() => _SmeupSplashState();
}

class _SmeupSplashState extends State<SmeupSplash>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupSplashModel? _model;

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

    children = Container(
      color: widget.color,
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
