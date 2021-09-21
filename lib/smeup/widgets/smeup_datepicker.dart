import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_datepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_datepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

import 'smeup_not_available.dart';

// ignore: must_be_immutable
class SmeupDatePicker extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  final SmeupDatePickerModel model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  String data;
  String title;
  String id;
  String type;

  //Graphics properties
  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  double padding;
  bool showborder;
  double elevation;

  SmeupDatePicker.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupDatePicker(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'cal',
      this.title = '',
      this.backColor,
      this.fontsize = SmeupDatePickerModel.defaultFontsize,
      this.fontColor,
      this.label = SmeupDatePickerModel.defaultLabel,
      this.width = SmeupDatePickerModel.defaultWidth,
      this.height = SmeupDatePickerModel.defaultHeight,
      this.padding = SmeupDatePickerModel.defaultPadding,
      this.showborder = SmeupDatePickerModel.defaultShowBorder,
      this.elevation = SmeupDatePickerModel.defaultElevation,
      this.model})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  runControllerActivities(SmeupModel model) {
    SmeupDatePickerModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    backColor = m.backColor;
    fontsize = m.fontsize;
    fontColor = m.fontColor;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showborder;
    elevation = m.elevation;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupDatePickerModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(element['value'].toString());
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupDatePickerState createState() => _SmeupDatePickerState();
}

class _SmeupDatePickerState extends State<SmeupDatePicker>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupDatePickerModel _model;
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
    Widget datePicker = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return datePicker;
  }

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupDatePickerDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    String valueField = _data.optionsDefault == null
        ? 'value'
        : _data.optionsDefault['valueField'];
    final valueString = _data.data['rows'][0][valueField];

    final value = DateTime.tryParse(valueString);

    String displayedField = _data.optionsDefault == null
        ? 'display'
        : _data.optionsDefault['displayedField'];
    String display = DateFormat("dd/MM/yyyy")
        .format(DateTime.tryParse(_data['rows'][0][displayedField]));

    SmeupVariablesService.setVariable(_data.id, valueString);

    var timepicker = SmeupDatePickerButton(
        widget.model, widget.scaffoldKey, widget.formKey, value, display);

    return SmeupWidgetBuilderResponse(_model, timepicker);
  }
}
