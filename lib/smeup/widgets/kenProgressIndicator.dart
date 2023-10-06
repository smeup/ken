import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_progress_indicator_model.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

// ignore: must_be_immutable
class KenProgressIndicator extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenProgressIndicatorModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  Color? circularTrackColor;
  String? title;
  String? id;
  String? type;
  double? size;

  KenProgressIndicator.withController(
    KenProgressIndicatorModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenProgressIndicator(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.color = KenProgressIndicatorModel.defaultColor,
      this.circularTrackColor =
          KenProgressIndicatorModel.defaultCircularTrackColor,
      this.size = KenProgressIndicatorModel.defaultSize,
      this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(KenModel model) {
    KenProgressIndicatorModel m = model as KenProgressIndicatorModel;
    id = m.id;
    type = m.type;
    color = m.color;
    circularTrackColor = m.circularTrackColor;
    title = m.title;
    size = m.size;
  }

  @override
  dynamic treatData(KenModel model) {
    KenProgressIndicatorModel m = model as KenProgressIndicatorModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  State<KenProgressIndicator> createState() => _KenProgressIndicatorState();
}

class _KenProgressIndicatorState extends State<KenProgressIndicator>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenProgressIndicatorModel? _model;

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
        widgetLoadType = LoadType.immediate;
        setDataLoad(widget.id, false);
      });
    });

    return pgi;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
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

    return KenWidgetBuilderResponse(_model, children);
  }
}
