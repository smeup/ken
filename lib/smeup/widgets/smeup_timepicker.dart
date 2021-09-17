import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_not_available.dart';
import 'smeup_widget_interface.dart';
import 'smeup_widget_mixin.dart';

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
  double padding;
  bool showborder;
  List<String> minutesList;

  // Data injected through static constructor
  dynamic data;

  // They have to be mapped with all the dynamisms
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;

  TextInputType keyboard;

  SmeupTimePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    id = '',
    type = 'tpk',
    this.backColor,
    this.fontsize = SmeupTimePickerModel.defaultFontsize,
    this.fontColor,
    this.label = SmeupTimePickerModel.defaultLabel,
    this.width = SmeupTimePickerModel.defaultWidth,
    this.height = SmeupTimePickerModel.defaultHeight,
    this.padding = SmeupTimePickerModel.defaultPadding,
    this.showborder = SmeupTimePickerModel.defaultShowBorder,
    this.minutesList,
    this.clientValidator,
    this.clientOnSave,
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
    SmeupTimePickerModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    // if (workData != null) {
    //   var newList = List<String>.empty(growable: true);
    //   for (var i = 0; i < (workData['rows'] as List).length; i++) {
    //     final element = workData['rows'][i];
    //     newList.add(element[m.valueColName].toString());
    //   }
    //   return newList;
    // } else {
    //   return model.data;
    // }
  }

  @override
  _SmeupTimePickerState createState() => _SmeupTimePickerState();
}

class _SmeupTimePickerState extends State<SmeupTimePicker>
    with SmeupWidgetStateMixin {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getTimePickerComponent(widget.model),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.model.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupTimePicker: ${snapshot.error}',
                logType: LogType.error);
            notifyError(context, widget.model.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(
    //     widget.scaffoldKey.hashCode,
    //     widget.smeupTimePickerModel.id,
    //     widget.smeupTimePickerModel.type,
    //     notifier);

    return input;
  }

  Future<SmeupWidgetBuilderResponse> _getTimePickerComponent(
      SmeupTimePickerModel smeupTimePickerModel) async {
    Widget timepicker;

    await smeupTimePickerModel.setData();

    if (!hasData(smeupTimePickerModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              '${SmeupLocalizationService.of(context).getLocalString('dataNotAvailable')}.  (${smeupTimePickerModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupTimePickerModel, SmeupNotAvailable());
    }

    String valueField = smeupTimePickerModel.optionsDefault == null
        ? 'value'
        : smeupTimePickerModel.optionsDefault['valueField'];
    final valueString = smeupTimePickerModel.data['rows'][0][valueField];

    final split = valueString.split(':');
    final now = DateTime.now();
    final value = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${split[0]}:${split[1]}:00');

    String displayedField = smeupTimePickerModel.optionsDefault == null
        ? 'display'
        : smeupTimePickerModel.optionsDefault['displayedField'];
    String display = smeupTimePickerModel.data['rows'][0][displayedField];

    SmeupDynamismService.variables[smeupTimePickerModel.id] = valueString;

    timepicker =
        SmeupTimePickerButton(widget.smeupTimePickerModel, value, display);

    return SmeupWidgetBuilderResponse(smeupTimePickerModel, timepicker);
  }
}
