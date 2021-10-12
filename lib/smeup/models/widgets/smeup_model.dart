import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum LoadType { Immediate, Delay }
enum WidgetOrientation { Vertical, Horizontal }

abstract class SmeupModel {
  //static const int defaultRefresh = 0;

  dynamic jsonMap;
  dynamic data;
  String type;
  String id;
  SmeupFun smeupFun;
  LoadType widgetLoadType = LoadType.Immediate;
  Map<String, dynamic> options;
  dynamic optionsType;
  Map<String, dynamic> optionsDefault;
  String title = '';
  SmeupModel parent;

  dynamic dynamisms;
  bool showLoader = false;
  bool notificationEnabled = true;
  bool isNotified = false;
  int serviceStatusCode = 0;
  //int refresh;
  GlobalKey<FormState> formKey;

  List<SmeupSectionModel> smeupSectionsModels;

  SmeupModel(this.formKey, {this.title, this.id, this.type}) {
    showLoader = SmeupConfigurationService.getAppConfiguration().showLoader;
    if (optionsDefault == null)
      optionsDefault = {
        "$type": {"default": {}}
      };
  }

  SmeupModel.fromMap(Map<String, dynamic> jsonMap, this.formKey) {
    this.jsonMap = jsonMap;
    type = jsonMap['type'];
    dynamisms = jsonMap['dynamisms'];

    if (type != null && (id == null || id.isEmpty)) {
      id = SmeupUtilities.getWidgetId(jsonMap['type'], jsonMap['id']);

      smeupFun = SmeupFun(jsonMap['fun'], formKey);

      switch (jsonMap['load']) {
        case 'D':
          widgetLoadType = LoadType.Delay;
          break;
        default:
          widgetLoadType = LoadType.Immediate;
      }

      options = jsonMap['options'] ?? Map<String, dynamic>();

      if (options[jsonMap['type']] == null)
        options[jsonMap['type']] = Map<String, dynamic>();

      optionsType = options[jsonMap['type']];

      if (optionsType['default'] == null)
        optionsType['default'] = Map<String, dynamic>();

      optionsDefault = optionsType['default'] ?? Map<String, dynamic>();
      showLoader = jsonMap['showLoader'] ??
          SmeupConfigurationService.getAppConfiguration().showLoader;
      notificationEnabled = jsonMap['notification'] ?? true;
      // refresh =
      //     SmeupUtilities.getInt(optionsDefault['refresh']) ?? defaultRefresh;
    }

    data = jsonMap['data'];
  }
}
