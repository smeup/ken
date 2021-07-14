import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_buttons.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_calendar.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_dashboard.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_image.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_line.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_qrcode_reader.dart';
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
                'Error SmeupComponent: ${snapshot.error}',
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

        children = SmeupCalendar(smeupModel, widget.scaffoldKey, widget.formKey,
            initialFirstWork, initialLastWork);
        break;
      case 'CHA':
        children = SmeupChart(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'BTN':
        children = SmeupButtons(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'BOX':
        children = SmeupListBox(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'LIN':
        children = SmeupLine(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'DSH':
        children =
            SmeupDashboard(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'IMG':
        children = SmeupImage(smeupModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'FLD':
        switch (smeupModel.options['FLD']['default']['type']) {
          case 'itx':
            children =
                SmeupTextField(smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'sld':
            children =
                SmeupSlider(smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'pgb':
            children = SmeupProgressBar(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'rad':
            children = SmeupRadioButtons(
                smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'tpk':
            children =
                SmeupTimePicker(smeupModel, widget.scaffoldKey, widget.formKey);
            break;

          case 'qrc':
            children = SmeupQRCodeReader(
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
          double deviceHeight = SmeupOptions.deviceHeight;
          double deviceWidth = SmeupOptions.deviceWidth;

          var smeupJsonForm =
              SmeupFormModel.fromMap(smeupServiceResponse.result.data);
          final form =
              SmeupForm(smeupJsonForm, widget.scaffoldKey, widget.formKey);

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
