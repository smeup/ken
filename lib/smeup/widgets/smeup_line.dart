import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_line_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_line_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupLine extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupLineModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color color;
  double thickness;
  String title;
  String id;
  String type;

  dynamic data;

  SmeupLine(this.scaffoldKey, this.formKey,
      {this.title, this.id = '', this.type = 'LIN', this.color, this.thickness})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupLineModel.setDefaults(this);
  }

  SmeupLine.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupLineModel m = model;
    id = m.id;
    type = m.type;
    color = m.color;
    thickness = m.thickness;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupLineModel m = model;

    // change data format
    return formatDataFields(m);
  }

  @override
  _SmeupLineState createState() => _SmeupLineState();
}

class _SmeupLineState extends State<SmeupLine>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupLineModel _model;
  // ignore: unused_field
  dynamic _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupLineDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    DividerThemeData captionStyle = _getDividerStile();

    final children = Divider(
      color: captionStyle.color,
      thickness: captionStyle.thickness,
    );
    return SmeupWidgetBuilderResponse(_model, children);
  }

  DividerThemeData _getDividerStile() {
    DividerThemeData dividerData = SmeupConfigurationService.getTheme()
        .dividerTheme
        .copyWith(color: widget.color, thickness: widget.thickness);

    return dividerData;
  }
}
