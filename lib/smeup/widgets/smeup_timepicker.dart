import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_timepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_widget_interface.dart';
import 'smeup_widget_mixin.dart';

class SmeupTimePickerData {
  DateTime time;
  String formattedTime;

  SmeupTimePickerData({@required this.time, this.formattedTime});
}

// ignore: must_be_immutable
class SmeupTimePicker extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTimePickerModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  String id;
  String type;

  // Graphics properties
  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  List<String> minutesList;

  String valueField;
  String displayField;

  // Data injected through static constructor
  SmeupTimePickerData data;

  // They have to be mapped with all the dynamisms
  // Function clientValidator;
  // Function clientOnSave;
  Function clientOnChange;

  TextInputType keyboard;

  SmeupTimePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    id = '',
    type = 'tpk',

    // TODO is it required in static constructor ?
    // this.valueField = SmeupTimePickerModel.defaultValueField,
    // this.displayField = SmeupTimePickerModel.defaultdisplayedField,

    this.backColor = SmeupTimePickerModel.defaultBackColor,
    this.fontsize = SmeupTimePickerModel.defaultFontsize,
    this.fontColor = SmeupTimePickerModel.defaultFontColor,
    this.label = SmeupTimePickerModel.defaultLabel,
    this.width = SmeupTimePickerModel.defaultWidth,
    this.height = SmeupTimePickerModel.defaultHeight,
    this.padding = SmeupTimePickerModel.defaultPadding,
    this.showborder = SmeupTimePickerModel.defaultShowBorder,
    this.minutesList,
    //this.clientValidator,
    //this.clientOnSave,
    this.clientOnChange,
    this.keyboard,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id)));

  SmeupTimePicker.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTimePickerModel m = model;
    id = m.id;
    type = m.type;
    valueField = m.valueField;
    displayField = m.displayedField;
    backColor = m.backColor;
    fontsize = m.fontsize;
    fontColor = m.fontColor;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showborder;
    minutesList = m.minutesList;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    // change data format
    final workData = formatDataFields(model);

    String display;
    DateTime value;

    final now = DateTime.now();

    if (workData != null) {
      final valueString = workData['rows'][0][valueField];
      final split = valueString.split(':');
      value = DateTime.parse(
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${split[0]}:${split[1]}:00');

      display = workData['rows'][0][displayField];
    } else {
      value = now;
      display = DateFormat('HH:mm').format(value);
    }

    return SmeupTimePickerData(time: value, formattedTime: display);
  }

  @override
  _SmeupTimePickerState createState() => _SmeupTimePickerState();
}

class _SmeupTimePickerState extends State<SmeupTimePicker>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTimePickerModel _model;
  SmeupTimePickerData _data;

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
    Widget timePicker = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return timePicker;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupTimePickerDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    Widget timepicker;

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    if (_model != null) {
      SmeupVariablesService.setVariable(_model.id, _data.formattedTime);
    }

    double timePickerHeight = widget.height;
    double timePickerWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (timePickerHeight == 0)
        timePickerHeight = (_model.parent as SmeupSectionModel).height;
      if (timePickerWidth == 0)
        timePickerWidth = (_model.parent as SmeupSectionModel).width;
    }

    timepicker = SmeupTimePickerButton(
      widget.formKey,
      _data,
      id: widget.id,
      backColor: widget.backColor,
      fontsize: widget.fontsize,
      fontColor: widget.fontColor,
      label: widget.label,
      width: timePickerWidth,
      height: timePickerHeight,
      padding: widget.padding,
      showborder: widget.showborder,
      minutesList: widget.minutesList,
      clientOnChange: widget.clientOnChange,
    );
    return SmeupWidgetBuilderResponse(_model, timepicker);
  }
}
