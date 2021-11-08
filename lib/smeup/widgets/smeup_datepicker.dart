import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_datepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_datepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupDatePicker extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupDatePickerModel model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  List<dynamic> data;
  String title;
  String id;
  String type;

  String valueField;
  String displayField;

  //Graphics properties
  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  double elevation;

  //Functions
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;

  SmeupDatePicker.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupDatePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    this.id = '',
    this.type = 'cal',
    this.title = '',

    // TODO is it required in static constructor ?
    // this.valueField = SmeupTimePickerModel.defaultValueField,
    // this.displayField = SmeupTimePickerModel.defaultdisplayedField,
    this.backColor = SmeupDatePickerModel.defaultBackColor,
    this.fontsize = SmeupDatePickerModel.defaultFontsize,
    this.fontColor = SmeupDatePickerModel.defaultFontColor,
    this.label = SmeupDatePickerModel.defaultLabel,
    this.width = SmeupDatePickerModel.defaultWidth,
    this.height = SmeupDatePickerModel.defaultHeight,
    this.padding = SmeupDatePickerModel.defaultPadding,
    this.showborder = SmeupDatePickerModel.defaultShowBorder,
    this.elevation = SmeupDatePickerModel.defaultElevation,
    this.clientValidator,
    this.clientOnSave,
    this.clientOnChange,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  runControllerActivities(SmeupModel model) {
    SmeupDatePickerModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    valueField = m.valueField;
    displayField = m.displayedField;
    backColor = m.backColor;
    fontsize = m.fontsize;
    fontColor = m.fontColor;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showBorder;
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
      var newList = List<dynamic>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'value': element[valueField].toString(),
          'display': element[displayField].toString()
        });
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

    /*
    String valueField = _data.optionsDefault == null
        ? 'value'
        : _data.optionsDefault['valueField'];
    */
    final valueString = _data[0]['value'];

    final value = new DateFormat('dd/MM/yyyy').parse(valueString);

    /*
    String displayedField = _data.optionsDefault == null
        ? 'display'
        : _data.optionsDefault['displayedField'];
    */

    final displayDate = new DateFormat('dd/MM/yyyy').parse(_data[0]['display']);

    String display = DateFormat("dd/MM/yyyy").format(displayDate);

    SmeupVariablesService.setVariable(widget.id, valueString);

    double datePickerHeight = widget.height;
    double datePickerWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (datePickerHeight == 0)
        datePickerHeight = (_model.parent as SmeupSectionModel).height;
      if (datePickerWidth == 0)
        datePickerWidth = (_model.parent as SmeupSectionModel).width;
    }

    var datepicker = SmeupDatePickerButton(widget.id,
        scaffoldKey: widget.scaffoldKey,
        formKey: widget.formKey,
        value: value,
        display: display,
        backColor: widget.backColor,
        fontsize: widget.fontsize,
        fontColor: widget.fontColor,
        label: widget.label,
        width: datePickerWidth,
        height: datePickerHeight,
        padding: widget.padding,
        showborder: widget.showborder,
        elevation: widget.elevation);

    return SmeupWidgetBuilderResponse(_model, datepicker);
  }
}
