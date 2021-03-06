import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_form_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/widgets/smeup_buttons.dart';
import 'package:ken/smeup/widgets/smeup_calendar.dart';
import 'package:ken/smeup/widgets/smeup_carousel.dart';
import 'package:ken/smeup/widgets/smeup_combo.dart';
import 'package:ken/smeup/widgets/smeup_dashboard.dart';
import 'package:ken/smeup/widgets/smeup_datepicker.dart';
import 'package:ken/smeup/widgets/smeup_image.dart';
import 'package:ken/smeup/widgets/smeup_image_list.dart';
import 'package:ken/smeup/widgets/smeup_inputpanel.dart';
import 'package:ken/smeup/widgets/smeup_line.dart';
import 'package:ken/smeup/widgets/smeup_progress_indicator.dart';
import 'package:ken/smeup/widgets/smeup_qrcode_reader.dart';
import 'package:ken/smeup/widgets/smeup_splash.dart';
import 'package:ken/smeup/widgets/smeup_switch.dart';
import 'package:ken/smeup/widgets/smeup_text_autocomplete.dart';
import 'package:ken/smeup/widgets/smeup_text_password.dart';
import 'package:ken/smeup/widgets/smeup_timepicker.dart';
import 'package:ken/smeup/widgets/smeup_gauge.dart';
import 'package:ken/smeup/widgets/smeup_radio_buttons.dart';
import 'package:ken/smeup/widgets/smeup_text_field.dart';
import 'package:ken/smeup/widgets/smeup_list_box.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_progress_bar.dart';
import 'package:ken/smeup/widgets/smeup_slider.dart';
import 'package:ken/smeup/widgets/smeup_tree.dart';
import 'package:ken/smeup/widgets/smeup_wait.dart';
import '../models/widgets/smeup_buttons_model.dart';
import '../models/widgets/smeup_calendar_model.dart';
import '../models/widgets/smeup_carousel_model.dart';
import '../models/widgets/smeup_chart_model.dart';
import '../models/widgets/smeup_combo_model.dart';
import '../models/widgets/smeup_dashboard_model.dart';
import '../models/widgets/smeup_datepicker_model.dart';
import '../models/widgets/smeup_gauge_model.dart';
import '../models/widgets/smeup_image_list_model.dart';
import '../models/widgets/smeup_image_model.dart';
import '../models/widgets/smeup_input_panel_model.dart';
import '../models/widgets/smeup_label_model.dart';
import '../models/widgets/smeup_line_model.dart';
import '../models/widgets/smeup_list_box_model.dart';
import '../models/widgets/smeup_progress_bar_model.dart';
import '../models/widgets/smeup_progress_indicator_model.dart';
import '../models/widgets/smeup_qrcode_reader_model.dart';
import '../models/widgets/smeup_radio_buttons_model.dart';
import '../models/widgets/smeup_slider_model.dart';
import '../models/widgets/smeup_splash_model.dart';
import '../models/widgets/smeup_switch_model.dart';
import '../models/widgets/smeup_text_autocomplete_model.dart';
import '../models/widgets/smeup_text_field_model.dart';
import '../models/widgets/smeup_text_password_model.dart';
import '../models/widgets/smeup_timepicker_model.dart';
import '../models/widgets/smeup_tree_model.dart';
import 'smeup_chart.dart';
import 'smeup_form.dart';
import 'smeup_label.dart';

class SmeupComponent extends StatefulWidget {
  final SmeupModel smeupModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;
  final dynamic parentForm;

  SmeupComponent(
      this.smeupModel, this.scaffoldKey, this.formKey, this.parentForm);

  @override
  _SmeupComponentState createState() => _SmeupComponentState();
}

class _SmeupComponentState extends State<SmeupComponent> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getComponentChildren(widget.smeupModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupModel.showLoader!
              ? SmeupWait(widget.scaffoldKey, widget.formKey)
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupComponent ( type: ${widget.smeupModel.type} , id: ${widget.smeupModel.id} ) : ${snapshot.error}. StackTrace: ${snapshot.stackTrace}',
                logType: LogType.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data!.children!;
          }
        }
      },
    );
  }

  Future<SmeupWidgetBuilderResponse> _getComponentChildren(
      SmeupModel smeupModel) async {
    var children;

    // SmeupLogService.writeDebugMessage("smeupModel.type: ${smeupModel.type}",
    //     logType: LogType.debug);
    switch (smeupModel.type) {
      case 'LAB':
        children = SmeupLabel.withController(
            smeupModel as SmeupLabelModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'GAU':
        children = SmeupGauge.whitController(
            smeupModel as SmeupGaugeModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'CAU':
        children = SmeupCarousel.withController(
            smeupModel as SmeupCarouselModel,
            widget.scaffoldKey,
            widget.formKey);
        break;
      case 'TRE':
        children = SmeupTree.withController(
            smeupModel as SmeupTreeModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'CAL':
        DateTime initialFirstWork;
        DateTime initialLastWork;

        initialFirstWork = DateTime.now();
        initialLastWork =
            DateTime(DateTime.now().year, DateTime.now().month + 1, 0);

        children = SmeupCalendar.withController(
            smeupModel as SmeupCalendarModel,
            widget.scaffoldKey,
            widget.formKey,
            initialFirstWork,
            initialLastWork);
        break;
      case 'CHA':
        children = SmeupChart.withController(
            smeupModel as SmeupChartModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'BTN':
        children = SmeupButtons.withController(smeupModel as SmeupButtonsModel,
            widget.scaffoldKey, widget.formKey);
        break;
      case 'BOX':
        children = SmeupListBox.withController(smeupModel as SmeupListBoxModel,
            widget.scaffoldKey, widget.formKey, widget.parentForm);
        break;
      case 'LIN':
        children = SmeupLine.withController(
            smeupModel as SmeupLineModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'DSH':
        children = SmeupDashboard.withController(
            smeupModel as SmeupDashboardModel,
            widget.scaffoldKey,
            widget.formKey);
        break;
      case 'IMG':
        children = SmeupImage.withController(
            smeupModel as SmeupImageModel, widget.scaffoldKey, widget.formKey);
        break;
      case 'IML':
        children = SmeupImageList.withController(
            smeupModel as SmeupImageListModel,
            widget.scaffoldKey,
            widget.formKey,
            widget.parentForm);
        break;
      case 'FLD':
        switch (smeupModel.options!['FLD']['default']['type']) {
          case 'acp':
            children = SmeupTextAutocomplete.withController(
                smeupModel as SmeupTextAutocompleteModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'cal':
            children = SmeupDatePicker.withController(
                smeupModel as SmeupDatePickerModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'cmb':
            children = SmeupCombo.withController(smeupModel as SmeupComboModel,
                widget.scaffoldKey, widget.formKey);
            break;

          case 'itx':
            children = SmeupTextField.withController(
                smeupModel as SmeupTextFieldModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'pgb':
            children = SmeupProgressBar.withController(
                smeupModel as SmeupProgressBarModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'pgi':
            children = SmeupProgressIndicator.withController(
                smeupModel as SmeupProgressIndicatorModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'qrc':
            children = SmeupQRCodeReader.withController(
                smeupModel as SmeupQRCodeReaderModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'pwd':
            children = SmeupTextPassword.withController(
                smeupModel as SmeupTextPasswordModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'rad':
            children = SmeupRadioButtons.withController(
                smeupModel as SmeupRadioButtonsModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'sld':
            children = SmeupSlider.withController(
                smeupModel as SmeupSliderModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'spl':
            children = SmeupSplash.withController(
                smeupModel as SmeupSplashModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'swt':
            children = SmeupSwitch.withController(
                smeupModel as SmeupSwitchModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          case 'tpk':
            children = SmeupTimePicker.withController(
                smeupModel as SmeupTimePickerModel,
                widget.scaffoldKey,
                widget.formKey);
            break;

          default:
        }
        break;

      case 'INP':
        children = SmeupInputPanel.withController(
            smeupModel as SmeupInputPanelModel,
            widget.scaffoldKey,
            widget.formKey);
        break;

      case 'SCH':
        final smeupServiceResponse =
            await SmeupDataService.invoke(smeupModel.smeupFun);

        if (!smeupServiceResponse.succeded) {
          children = SmeupNotAvailable();
        } else {
          MediaQueryData deviceInfo = MediaQuery.of(context);
          double deviceHeight = deviceInfo.size.height;
          double deviceWidth = deviceInfo.size.width;

          var smeupJsonForm = SmeupFormModel.fromMap(
              smeupServiceResponse.result.data,
              widget.formKey,
              widget.scaffoldKey,
              context);
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
