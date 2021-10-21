import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupInputPanel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupInputPanelModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;
  String title;

  dynamic data;

  SmeupInputPanel(this.scaffoldKey, this.formKey,
      {this.id = '', this.type = 'INP', this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupInputPanel.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupInputPanelModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;

    return treatData(m);
  }

  @override
  _SmeupInputPanelState createState() => _SmeupInputPanelState();

  @override
  dynamic treatData(SmeupModel model) {
    SmeupInputPanelModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);

      // overrides model properties from data
      var firstElement = (workData['rows'] as List).first;

      return model.data;
    }
  }
}

class _SmeupInputPanelState extends State<SmeupInputPanel>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupInputPanelModel _model;
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
    Widget inputPanel = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return inputPanel;
  }
}
