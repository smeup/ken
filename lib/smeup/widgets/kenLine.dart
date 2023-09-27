import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_line_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenLine extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenLineModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  double? thickness;
  String? title;
  String? id;
  String? type;

  dynamic data;

  KenLine(this.scaffoldKey, this.formKey,
      {this.title, this.id = '', this.type = 'LIN', this.color, this.thickness})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenLineModel.setDefaults(this);
  }

  KenLine.withController(
    KenLineModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenLineModel m = model as KenLineModel;
    id = m.id;
    type = m.type;
    color = m.color;
    thickness = m.thickness;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenLineModel m = model as KenLineModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  _KenLineState createState() => _KenLineState();
}

class _KenLineState extends State<KenLine>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenLineModel? _model;
  // ignore: unused_field
  dynamic _data;

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
    Widget line = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return line;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupLineDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    DividerThemeData captionStyle = _getDividerStile();

    final children = Divider(
      color: captionStyle.color,
      thickness: captionStyle.thickness,
    );
    return KenWidgetBuilderResponse(_model, children);
  }

  DividerThemeData _getDividerStile() {
    DividerThemeData dividerData =
        DividerThemeData(color: widget.color, thickness: widget.thickness);

    return dividerData;
  }
}
