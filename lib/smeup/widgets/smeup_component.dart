import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_calendar.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_dashboard.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_datepicker.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_image.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_line.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_qrcode_reader.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_autocomplete.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_gauge.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_text_field.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_list_box.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_progress_bar.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_slider.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_tree.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'smeup_chart.dart';
import 'smeup_form.dart';
import 'smeup_label.dart';

class SmeupComponent extends StatefulWidget {
  final SmeupModel smeupModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupComponent(this.smeupModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupComponentState createState() => _SmeupComponentState();
}

class _SmeupComponentState extends State<SmeupComponent> {
  @override
  Widget build(BuildContext context) {
    //MediaQueryData deviceInfo = MediaQuery.of(context);

    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getComponentChildren(widget.smeupModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupComponent ( type: ${widget.smeupModel.type} , id: ${widget.smeupModel.id} ) : ${snapshot.error}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> _getComponentChildren(
      SmeupModel smeupModel) async {
    var children;

    switch (smeupModel.type) {
      case 'LAB':
        children = SmeupLabel.withController(
            smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'GAU':
        children = SmeupGauge(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'TRE':
        children = SmeupTree(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'CAL':
        DateTime initialFirstWork;
        DateTime initialLastWork;

        initialFirstWork = DateTime.now();
        initialLastWork =
            DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

        children = SmeupCalendar.withController(smeupModel, widget.scaffoldKey,
            widget.formKey, initialFirstWork, initialLastWork);
        break;
      case 'CHA':
        children = SmeupChart(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'BTN':
        children = SmeupButtons.withController(
            smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'BOX':
        children = SmeupListBox.withController(
            smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'LIN':
        children = SmeupLine(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'DSH':
        children = SmeupDashboard.withController(
            smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'IMG':
        children = SmeupImage.withController(
            smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'FLD':
        switch (smeupModel.options['FLD']['default']['type']) {
          case 'acp':
            children = SmeupTextAutocomplete.withController(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'cal':
            children = SmeupDatePicker.withController(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'itx':
            children = SmeupTextField.withController(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'pgb':
            children = SmeupProgressBar(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'qrc':
            children = SmeupQRCodeReader(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'rad':
            children = SmeupRadioButtons.withController(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'sld':
            children =
                SmeupSlider(smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'tpk':
            children = SmeupTimePicker.withController(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          default:
        }
        break;

      case 'SCH':
        final smeupServiceResponse =
            await SmeupDataService.invoke(smeupModel.smeupFun);

        if (!smeupServiceResponse.succeded) {
          children = SmeupNotAvailable();
        } else {
          MediaQueryData deviceInfo = MediaQuery.of(context);
          SmeupConfigurationService.deviceWidth = deviceInfo.size.width;
          SmeupConfigurationService.deviceHeight = deviceInfo.size.height;
          double deviceHeight = SmeupConfigurationService.deviceHeight;
          double deviceWidth = SmeupConfigurationService.deviceWidth;

          var smeupJsonForm = SmeupFormModel.fromMap(
              smeupServiceResponse.result.data, widget.formKey);
          final form = SmeupForm(smeupJsonForm, widget.scaffoldKey);

          if (smeupJsonForm.layout == 'column') {
            children = Container(
                height: deviceHeight,
                width: deviceWidth,
                child: Column(children: [form]));
          } else {
            children = Container(
                height: deviceHeight,
                width: deviceWidth,
                child: Row(children: [form]));
          }
        }

        break;
      default:
        SmeupLogService.writeDebugMessage('component not defined',
            logType: LogType.error);
    }

    return SmeupWidgetBuilderResponse(smeupModel, children);
  }
}
