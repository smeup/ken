import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_carousel_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_chart_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_dashboard_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_gauge_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_input_field_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_line_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model_mixin.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_progress_bar_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_progress_indicator_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_splash_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_switch_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_text_field_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_tree_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

import 'smeup_datepicker_model.dart';

class SmeupSectionModel extends SmeupModel with SmeupModelMixin {
  double dim;
  //int size;
  String layout;
  List<SmeupModel> components;
  List<SmeupSectionModel> smeupSectionsModels;
  int selectedTabIndex;
  String selectedTabColName;

  SmeupSectionModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    String tmp = jsonMap['dim'] ?? '';
    tmp = tmp.replaceAll('%', '');
    dim = double.tryParse(tmp) ?? 0;
    // if (dim != 0) {
    //   dim = (dim / 10);
    // }
    layout = jsonMap['layout'];
    selectedTabColName = jsonMap['selectedTabColName'];
    _replaceSelectedTabIndex(jsonMap);

    components = getComponents(jsonMap, 'components');
    smeupSectionsModels = getSections(jsonMap, 'sections', formKey);
  }

  void _replaceSelectedTabIndex(dynamic jsonMap) {
    if (jsonMap['selectedTabColName'] != null) {
      selectedTabIndex = int.tryParse(SmeupDynamismService.replaceFunVariables(
          '[${jsonMap['selectedTabColName']}]', formKey));
    }
    if (selectedTabIndex == null) selectedTabIndex = 0;
  }

  bool hasComponents() {
    return components != null && components.length > 0;
  }

  List<SmeupModel> getComponents(jsonMap, componentName) {
    final components = List<SmeupModel>.empty(growable: true);

    if (jsonMap.containsKey(componentName)) {
      List<dynamic> componentsJson = jsonMap[componentName];
      componentsJson.forEach((v) {
        dynamic model;

        try {
          switch (v['type']) {
            case 'LAB': // ok
              model = SmeupLabelModel.fromMap(v, formKey);
              break;
            case 'GAU':
              model = SmeupGaugeModel.fromMap(v, formKey);
              break;
            case 'CAU':
              model = SmeupCarouselModel.fromMap(v, formKey);
              break;
            case 'TRE':
              model = SmeupTreeModel.fromMap(v, formKey);
              break;
            case 'CAL':
              model = SmeupCalendarModel.fromMap(v, formKey);
              break;
            case 'CHA':
              model = SmeupChartModel.fromMap(v, formKey);
              break;
            case 'BTN':
              model = SmeupButtonsModel.fromMap(v, formKey);
              break;
            case 'BOX':
              model = SmeupListBoxModel.fromMap(v, formKey);
              break;
            case 'DSH':
              model = SmeupDashboardModel.fromMap(v, formKey);
              break;
            case 'LIN':
              model = SmeupLineModel.fromMap(v, formKey);
              break;
            case 'IMG':
              model = SmeupImageModel.fromMap(v, formKey);
              break;
            case 'FLD':
              switch (v['options']['FLD']['default']['type']) {
                case 'acp':
                  model = SmeupTextAutocompleteModel.fromMap(v, formKey);
                  break;
                case 'cal':
                  model = SmeupDatePickerModel.fromMap(v, formKey);
                  break;
                case 'itx':
                  model = SmeupTextFieldModel.fromMap(v, formKey);
                  break;
                case 'pgb':
                  model = SmeupProgressBarModel.fromMap(v, formKey);
                  break;
                case 'pgi':
                  model = SmeupProgressIndicatorModel.fromMap(v, formKey);
                  break;
                case 'qrc':
                  model = SmeupQRCodeReaderModel.fromMap(v, formKey);
                  break;
                case 'rad':
                  model = SmeupRadioButtonsModel.fromMap(v, formKey);
                  break;
                case 'sld':
                  model = SmeupInputFieldModel.fromMap(v, formKey);
                  break;
                case 'spl':
                  model = SmeupSplashModel.fromMap(v, formKey);
                  break;
                case 'swt':
                  model = SmeupSwitchModel.fromMap(v, formKey);
                  break;
                case 'tpk':
                  model = SmeupTimePickerModel.fromMap(v, formKey);
                  break;

                default:
              }

              break;
            case 'SCH':
              model = SmeupFormModel.fromMap(v, formKey);
              break;
            case 'DRW':
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

        if (model != null) components.add(model);
      });
    }

    return components;
  }
}
