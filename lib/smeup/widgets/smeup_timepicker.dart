import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'smeup_not_available.dart';

class SmeupTimePicker extends StatefulWidget {
  final SmeupTimePickerModel smeupTimePickerModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientValidator;
  final Function clientOnSave;
  final Function clientOnChange;
  final TextInputType keyboard;

  SmeupTimePicker(this.smeupTimePickerModel, this.scaffoldKey, this.formKey,
      {this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard});

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
      future: _getTimePickerComponent(widget.smeupTimePickerModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupTimePickerModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupTimePicker: ${snapshot.error}',
                logType: LogType.error);
            notifyError(
                context, widget.smeupTimePickerModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

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
          backgroundColor: SmeupConfigurationService.getTheme().errorColor,
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

    SmeupVariablesService.setVariable(smeupTimePickerModel.id, valueString,
        formKey: widget.formKey);

    timepicker = SmeupTimePickerButton(
        widget.smeupTimePickerModel, widget.formKey, value, display);

    return SmeupWidgetBuilderResponse(smeupTimePickerModel, timepicker);
  }
}
