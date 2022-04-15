import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:ken/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:ken/smeup/models/widgets/smeup_carousel_model.dart';
import 'package:ken/smeup/models/widgets/smeup_chart_model.dart';
import 'package:ken/smeup/models/widgets/smeup_combo_model.dart';
import 'package:ken/smeup/models/widgets/smeup_dashboard_model.dart';
import 'package:ken/smeup/models/widgets/smeup_form_model.dart';
import 'package:ken/smeup/models/widgets/smeup_gauge_model.dart';
import 'package:ken/smeup/models/widgets/smeup_image_list_model.dart';
import 'package:ken/smeup/models/widgets/smeup_image_model.dart';
import 'package:ken/smeup/models/widgets/smeup_inputpanel_model.dart';
import 'package:ken/smeup/models/widgets/smeup_label_model.dart';
import 'package:ken/smeup/models/widgets/smeup_line_model.dart';
import 'package:ken/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model_mixin.dart';
import 'package:ken/smeup/models/widgets/smeup_progress_bar_model.dart';
import 'package:ken/smeup/models/widgets/smeup_progress_indicator_model.dart';
import 'package:ken/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:ken/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:ken/smeup/models/widgets/smeup_slider_model.dart';
import 'package:ken/smeup/models/widgets/smeup_splash_model.dart';
import 'package:ken/smeup/models/widgets/smeup_switch_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_field_model.dart';
import 'package:ken/smeup/models/widgets/smeup_text_password_model.dart';
import 'package:ken/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:ken/smeup/models/widgets/smeup_tree_model.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';

import '../../services/smeup_utilities.dart';
import 'smeup_datepicker_model.dart';

class SmeupSectionModel extends SmeupModel with SmeupModelMixin {
  double? dim;
  String? layout;
  List<SmeupModel>? components;
  List<SmeupSectionModel>? smeupSectionsModels;
  int? selectedTabIndex;
  String? selectedTabColName;
  double? width;
  double? height;
  bool? autoAdaptHeight;
  SmeupModel? parentForm;

  SmeupSectionModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      BuildContext? context,
      SmeupModel parent,
      GlobalKey<ScaffoldState>? scaffoldKey)
      : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    String tmp = jsonMap['dim'] ?? '';
    tmp = tmp.replaceAll('%', '');
    dim = double.tryParse(tmp) ?? 0;
    id = SmeupUtilities.getWidgetId('', jsonMap['id']);
    layout = jsonMap['layout'];
    selectedTabColName = jsonMap['selectedTabColName'];
    if (parent is SmeupFormModel) {
      autoAdaptHeight = parent.autoAdaptHeight;
      parentForm = parent;
    }
    if (parent is SmeupSectionModel) {
      autoAdaptHeight = parent.autoAdaptHeight;
      parentForm = parent.parentForm;
    }

    _replaceSelectedTabIndex(jsonMap);

    components = getComponents(jsonMap, 'components');
    smeupSectionsModels = getSections(jsonMap, 'sections', formKey, scaffoldKey,
        context, autoAdaptHeight, parent);
  }

  void _replaceSelectedTabIndex(dynamic jsonMap) {
    if (jsonMap['selectedTabColName'] != null) {
      selectedTabIndex = int.tryParse(SmeupDynamismService.replaceVariables(
          '[${jsonMap['selectedTabColName']}]', formKey));
    }
    if (selectedTabIndex == null) selectedTabIndex = 0;
  }

  bool hasComponents() {
    return components != null && components!.length > 0;
  }

  bool hasSections() {
    return smeupSectionsModels != null && smeupSectionsModels!.length > 0;
  }

  List<SmeupModel> getComponents(jsonMap, componentName) {
    final components = List<SmeupModel>.empty(growable: true);

    if (jsonMap.containsKey(componentName)) {
      List<dynamic> componentsJson = jsonMap[componentName];
      componentsJson.forEach((v) async {
        SmeupModel? model;

        try {
          switch (v['type']) {
            case 'LAB': // ok
              model = SmeupLabelModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'GAU':
              model = SmeupGaugeModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CAU':
              model =
                  SmeupCarouselModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'TRE':
              model = SmeupTreeModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CAL':
              model =
                  SmeupCalendarModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CHA':
              model = SmeupChartModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'BTN':
              model =
                  SmeupButtonsModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'BOX':
              model =
                  SmeupListBoxModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'DSH':
              model =
                  SmeupDashboardModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'LIN':
              model = SmeupLineModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'IMG':
              model = SmeupImageModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'IML':
              model =
                  SmeupImageListModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'FLD':
              switch (v['options']['FLD']['default']['type']) {
                case 'acp':
                  model = SmeupTextAutocompleteModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'cal':
                  model = SmeupDatePickerModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'cmb':
                  model = SmeupComboModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'itx':
                  model = SmeupTextFieldModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'pgb':
                  model = SmeupProgressBarModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'pgi':
                  model = SmeupProgressIndicatorModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'pwd':
                  model = SmeupTextPasswordModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'qrc':
                  model = SmeupQRCodeReaderModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'rad':
                  model = SmeupRadioButtonsModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'sld':
                  model = SmeupSliderModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'spl':
                  model = SmeupSplashModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'swt':
                  model = SmeupSwitchModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'tpk':
                  model = SmeupTimePickerModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;

                default:
              }

              break;
            case 'SCH':
              model = SmeupFormModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'DRW':
              break;

            case 'INP': // ok
              model = SmeupInputPanelModel.fromMap(
                  v, formKey, scaffoldKey, context);
              break;
            default:
              SmeupLogService.writeDebugMessage(
                  'component not defined: ${v['type']}',
                  logType: LogType.error);
          }
        } catch (e) {
          final msg =
              'SmeupSectionModel - getComponents - Error while creating the model ${v['type']} ';
          SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
          throw (msg);
        }

        if (model != null) {
          if (model.parent == null) model.parent = this;
          components.add(model);
        }
      });
    }

    return components;
  }

  Future<void> getSectionData() async {
    if (hasSections()) {
      for (var i = 0; i < smeupSectionsModels!.length; i++) {
        var section = smeupSectionsModels![i];
        await section.getSectionData();
      }
    }
    if (hasComponents()) {
      for (var i = 0; i < components!.length; i++) {
        var componentModel = components![i];
        if (componentModel.onReady != null) await componentModel.onReady!();
      }
    }
  }
}
