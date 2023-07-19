import 'package:flutter/material.dart';
import '../../services/ken_log_service.dart';
import 'ken_buttons_model.dart';
import 'ken_calendar_model.dart';
import 'ken_carousel_model.dart';
import 'ken_chart_model.dart';
import 'ken_combo_model.dart';
import 'ken_dashboard_model.dart';
import 'ken_form_model.dart';
import 'ken_gauge_model.dart';
import 'ken_image_list_model.dart';
import 'ken_image_model.dart';
import 'ken_input_panel_model.dart';
import 'ken_label_model.dart';
import 'ken_line_model.dart';
import 'ken_list_box_model.dart';
import 'ken_model.dart';
import 'ken_model_mixin.dart';
import 'ken_progress_bar_model.dart';
import 'ken_progress_indicator_model.dart';
import 'ken_qrcode_reader_model.dart';
import 'ken_radio_buttons_model.dart';
import 'ken_slider_model.dart';
import 'ken_splash_model.dart';
import 'ken_switch_model.dart';
import 'ken_text_autocomplete_model.dart';
import 'ken_text_field_model.dart';
import 'ken_text_password_model.dart';
import 'ken_timepicker_model.dart';

import '../../services/ken_utilities.dart';
import 'ken_datepicker_model.dart';
import 'ken_tree_model.dart';

class KenSectionModel extends KenModel with KenModelMixin {
  double? dim;
  String? layout;
  List<KenModel>? components;
  List<KenSectionModel>? smeupSectionsModels;
  int? selectedTabIndex;
  String? selectedTabColName;
  double? width;
  double? height;
  bool? autoAdaptHeight;
  KenModel? parentForm;

  KenSectionModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      BuildContext? context,
      KenModel parent,
      GlobalKey<ScaffoldState>? scaffoldKey)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    String tmp = jsonMap['dim'] ?? '';
    tmp = tmp.replaceAll('%', '');
    dim = double.tryParse(tmp) ?? 0;
    id = KenUtilities.getWidgetId('', jsonMap['id']);
    layout = jsonMap['layout'];
    selectedTabColName = jsonMap['selectedTabColName'];
    if (parent is KenFormModel) {
      autoAdaptHeight = parent.autoAdaptHeight;
      parentForm = parent;
    }
    if (parent is KenSectionModel) {
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
      selectedTabIndex = int.tryParse(KenUtilities.replaceVariables(
          '[${jsonMap['selectedTabColName']}]', formKey));
    }
    selectedTabIndex ??= 0;
  }

  bool hasComponents() {
    return components != null && components!.isNotEmpty;
  }

  bool hasSections() {
    return smeupSectionsModels != null && smeupSectionsModels!.isNotEmpty;
  }

  List<KenModel> getComponents(jsonMap, componentName) {
    final components = List<KenModel>.empty(growable: true);

    if (jsonMap.containsKey(componentName)) {
      List<dynamic> componentsJson = jsonMap[componentName];
      componentsJson.forEach((v) async {
        KenModel? model;

        try {
          switch (v['type']) {
            case 'LAB': // ok
              model = KenLabelModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'GAU':
              model = KenGaugeModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CAU':
              model =
                  KenCarouselModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'TRE':
              model = KenTreeModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CAL':
              model =
                  KenCalendarModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'CHA':
              model = KenChartModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'BTN':
              model = KenButtonsModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'BOX':
              model = KenListBoxModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'DSH':
              model =
                  KenDashboardModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'LIN':
              model = KenLineModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'IMG':
              model = KenImageModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'IML':
              model =
                  KenImageListModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'FLD':
              switch (v['options']['FLD']['default']['type']) {
                case 'acp':
                  model = KenTextAutocompleteModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'cal':
                  model = KenDatePickerModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'cmb':
                  model = KenComboModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'itx':
                  model = KenTextFieldModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'pgb':
                  model = KenProgressBarModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'pgi':
                  model = KenProgressIndicatorModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'pwd':
                  model = KenTextPasswordModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;
                case 'qrc':
                  model = KenQRCodeReaderModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'rad':
                  model = KenRadioButtonsModel.fromMap(
                      v, formKey, scaffoldKey, context, this);
                  break;
                case 'sld':
                  model =
                      KenSliderModel.fromMap(v, formKey, scaffoldKey, context);
                  break;
                case 'spl':
                  model =
                      KenSplashModel.fromMap(v, formKey, scaffoldKey, context);
                  break;
                case 'swt':
                  model =
                      KenSwitchModel.fromMap(v, formKey, scaffoldKey, context);
                  break;
                case 'tpk':
                  model = KenTimePickerModel.fromMap(
                      v, formKey, scaffoldKey, context);
                  break;

                default:
              }

              break;
            case 'SCH':
              model = KenFormModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            case 'DRW':
              break;

            case 'INP': // ok
              model =
                  KenInputPanelModel.fromMap(v, formKey, scaffoldKey, context);
              break;
            default:
              var v2 = {
                "loaded": true,
                "options": {
                  "LAB": {
                    "default": {
                      "padding": {"Top": 30},
                      "align": "center",
                      "height": 30
                    }
                  }
                },
                "data": {
                  "rows": [
                    {"value": "Component '${v['type']}' not supported yet"}
                  ]
                },
                "title": "Component unavailable",
                "type": "LAB"
              };

              model = KenLabelModel.fromMap(v2, formKey, scaffoldKey, context);

              KenLogService.writeDebugMessage(
                  'component not defined: ${v['type']}',
                  logType: KenLogType.error);
          }
        } catch (e) {
          final msg =
              'SmeupSectionModel - getComponents - Error while creating the model ${v['type']} ';
          KenLogService.writeDebugMessage(msg, logType: KenLogType.error);
          throw (msg);
        }

        if (model != null) {
          model.parent ??= this;
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
