import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_widget_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_datepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';
import 'package:provider/provider.dart';
import 'smeup_not_available.dart';

class SmeupDatePicker extends StatefulWidget {
  final SmeupDatePickerModel smeupDatePickerModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final Function clientValidator;
  final Function clientOnSave;
  final Function clientOnChange;
  final TextInputType keyboard;

  SmeupDatePicker(this.smeupDatePickerModel, this.scaffoldKey, this.formKey,
      {this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.keyboard});

  @override
  _SmeupDatePickerState createState() => _SmeupDatePickerState();
}

class _SmeupDatePickerState extends State<SmeupDatePicker>
    with SmeupWidgetStateMixin {
  @override
  void dispose() {
    // SmeupWidgetsNotifier.removeWidget(
    //     widget.scaffoldKey.hashCode, widget.smeupDatePickerModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupWidgetNotifier notifier =
        Provider.of<SmeupWidgetNotifier>(context);

    final input = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getTimePickerComponent(widget.smeupDatePickerModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupDatePickerModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupDatePicker: ${snapshot.error}',
                logType: LogType.error);
            notifyError(
                context, widget.smeupDatePickerModel.id, snapshot.error);
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
      SmeupDatePickerModel smeupDatePickerModel) async {
    Widget timepicker;

    await smeupDatePickerModel.setData();

    if (!hasData(smeupDatePickerModel)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupDatePickerModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupDatePickerModel, SmeupNotAvailable());
    }

    String valueField = smeupDatePickerModel.optionsDefault == null
        ? 'value'
        : smeupDatePickerModel.optionsDefault['valueField'];
    final valueString = smeupDatePickerModel.data['rows'][0][valueField];

    final value = DateTime.tryParse(valueString);

    String displayedField = smeupDatePickerModel.optionsDefault == null
        ? 'display'
        : smeupDatePickerModel.optionsDefault['displayedField'];
    String display = DateFormat("dd/MM/yyyy").format(DateTime.tryParse(
        smeupDatePickerModel.data['rows'][0][displayedField]));

    SmeupDynamismService.variables[smeupDatePickerModel.id] = valueString;

    timepicker =
        SmeupDatePickerButton(widget.smeupDatePickerModel, value, display);

    return SmeupWidgetBuilderResponse(smeupDatePickerModel, timepicker);
  }
}
