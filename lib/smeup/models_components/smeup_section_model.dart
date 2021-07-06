import 'package:mobile_components_library/smeup/models_components/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_calendar_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_chart_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_dashboard_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_form_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_gauge_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_input_field_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_line_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_model_mixin.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_qrcode_reader_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_radio_buttons_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_text_field_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_tree_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupSectionModel extends SmeupModel with SmeupModelMixin {
  double dim;
  //int size;
  String layout;
  List<SmeupModel> components;
  List<SmeupSectionModel> smeupSectionsModels;
  int selectedTabIndex;
  String selectedTabColName;

  SmeupSectionModel.fromJson(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
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
    smeupSectionsModels = getSections(jsonMap, 'sections');
  }

  void _replaceSelectedTabIndex(dynamic jsonMap) {
    if (jsonMap['selectedTabColName'] != null) {
      selectedTabIndex = int.tryParse(SmeupDynamismService.replaceFunVariables(
          '[${jsonMap['selectedTabColName']}]'));
    }
    if (selectedTabIndex == null) selectedTabIndex = 0;
  }

  bool hasSections() {
    return smeupSectionsModels != null && smeupSectionsModels.length > 0;
  }

  bool hasComponents() {
    return components != null && components.length > 0;
  }

  List<SmeupModel> getComponents(jsonMap, componentName) {
    final components = List<SmeupModel>.empty(growable: true);

    if (jsonMap.containsKey(componentName)) {
      List<dynamic> componentsJson = jsonMap[componentName];
      componentsJson.forEach((v) {
        //SmeupComponentModel smeupComponent = SmeupComponentModel.fromMap(v);
        dynamic model;

        try {
          switch (v['type']) {
            case 'LAB': // ok
              model = SmeupLabelModel.fromMap(v);
              break;
            case 'GAU':
              model = SmeupGaugeModel.fromMap(v);
              break;
            case 'TRE':
              model = SmeupTreeModel.fromMap(v);
              break;
            case 'CAL':
              model = SmeupCalendarModel.fromMap(v);
              break;
            case 'CHA':
              model = SmeupChartModel.fromMap(v);
              break;
            case 'BTN': // ok
              model = SmeupButtonsModel.fromMap(v);
              break;
            case 'BOX':
              model = SmeupListBoxModel.fromMap(v);
              break;
            case 'DSH':
              model = SmeupDashboardModel.fromMap(v);
              break;
            case 'LIN':
              model = SmeupLineModel.fromMap(v);
              break;
            case 'IMG':
              model = SmeupImageModel.fromMap(v);
              break;
            case 'FLD':
              switch (v['options']['FLD']['default']['type']) {
                case 'itx':
                  model = SmeupTextFieldModel.fromMap(v);
                  break;
                case 'sld':
                case 'pgb':
                  model = SmeupInputFieldModel.fromMap(v);
                  break;
                case 'rad':
                  model = SmeupRadioButtonsModel.fromMap(v);
                  break;
                case 'tpk':
                  model = SmeupTimePickerModel.fromMap(v);
                  break;
                case 'qrc':
                  model = SmeupQRCodeReaderModel.fromMap(v);
                  break;

                default:
              }

              break;
            case 'SCH':
              model = SmeupFormModel.fromMap(v);
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
