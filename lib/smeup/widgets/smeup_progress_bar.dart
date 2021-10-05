import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_progress_bar_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_progress_bar_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupProgressBar extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupProgressBarModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String title;
  String id;
  String type;
  Color color;
  String valueField;
  double progressBarMinimun;
  double progressBarMaximun;
  double height;
  EdgeInsetsGeometry padding;

  double data;

  Function clientOnChange;

  SmeupProgressBar.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupProgressBar(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.valueField = SmeupProgressBarModel.defaultValueField,
      this.color = SmeupProgressBarModel.defaultColor,
      this.title = '',
      this.height = SmeupProgressBarModel.defaultHeight,
      this.data = 0,
      this.padding = SmeupProgressBarModel.defaultPadding,
      this.progressBarMinimun = SmeupProgressBarModel.defaultProgressBarMinimun,
      this.progressBarMaximun = SmeupProgressBarModel.defaultProgressBarMaximun,
      this.clientOnChange})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupProgressBarModel m = model;
    id = m.id;
    type = m.type;
    color = m.color;
    title = m.title;
    valueField = m.valueField;
    progressBarMinimun = m.progressBarMinimun;
    progressBarMaximun = m.progressBarMaximun;
    height = m.height;
    padding = m.padding;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupProgressBarModel m = model;

    return SmeupUtilities.getDouble(m.data['rows'][0][m.valueField]);
  }

  @override
  _SmeupProgressBarState createState() => _SmeupProgressBarState();
}

class _SmeupProgressBarState extends State<SmeupProgressBar>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupProgressBarModel _model;
  double _data;

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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupProgressBarDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    Widget children;

    SmeupVariablesService.setVariable(widget.id, _data,
        formKey: widget.formKey);

    children = Center(
      child: Container(
          padding: widget.padding,
          child: LinearProgressIndicator(
            minHeight: widget.height,
            key: ValueKey(widget.id),
            value: widget.progressBarMaximun == 0
                ? 0
                : _data / widget.progressBarMaximun,
          )),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
