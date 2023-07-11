import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_splash_model.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenSplash extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenSplashModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  String? id;
  String? type;
  String? title;

  KenSplash(this.scaffoldKey, this.formKey,
      {this.id = '', this.type = 'FLD', this.color, this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenSplashModel.setDefaults(this);
  }

  KenSplash.withController(
    KenSplashModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenSplashModel m = model as KenSplashModel;
    id = m.id;
    type = m.type;
    color = m.color;
    title = m.title;
  }

  @override
  dynamic treatData(KenModel model) {
    KenSplashModel m = model as KenSplashModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  State<KenSplash> createState() => _KenSplashState();
}

class _KenSplashState extends State<KenSplash>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenSplashModel? _model;

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
  Future<KenWidgetBuilderResponse> getChildren() async {
    Widget children;

    children = Container(
      color: widget.color,
    );

    return KenWidgetBuilderResponse(_model, children);
  }
}
