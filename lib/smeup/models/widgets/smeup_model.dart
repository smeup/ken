import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

enum LoadType { Immediate, Delay }
enum WidgetOrientation { Vertical, Horizontal }

abstract class SmeupModel {
  //static const int defaultRefresh = 0;

  dynamic data;
  String type;
  String id;
  SmeupFun smeupFun;
  LoadType widgetLoadType = LoadType.Immediate;
  LinkedHashMap<String, dynamic> options;
  dynamic optionsType;
  LinkedHashMap<String, dynamic> optionsDefault;
  String title = '';
  SmeupModel parent;

  dynamic dynamisms;
  bool showLoader = false;
  bool notificationEnabled = true;
  bool isNotified = false;
  int serviceStatusCode = 0;
  //int refresh;
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;
  Function onReady;

  List<SmeupSectionModel> smeupSectionsModels;

  SmeupModel(this.formKey, this.scaffoldKey, this.context,
      {this.title, this.id, this.type}) {
    showLoader = SmeupConfigurationService.getAppConfiguration().showLoader;
    if (optionsDefault == null) {
      optionsDefault = _getNewLinkedHashMap();
      options = _getNewLinkedHashMap();
      optionsType = _getNewLinkedHashMap();
    }
  }

  SmeupModel.fromMap(Map<String, dynamic> jsonMap, this.formKey,
      this.scaffoldKey, this.context) {
    var myJsonMap = _getNewLinkedHashMap();
    _setLinkedHashMap(jsonMap, myJsonMap);

    type = myJsonMap['type'];
    dynamisms = myJsonMap['dynamisms'];
    smeupFun = SmeupFun(myJsonMap['fun'], formKey, scaffoldKey, context);

    switch (myJsonMap['load']) {
      case 'D':
        widgetLoadType = LoadType.Delay;
        break;
      default:
        widgetLoadType = LoadType.Immediate;
    }

    showLoader = myJsonMap['showLoader'] ??
        SmeupConfigurationService.getAppConfiguration().showLoader;
    notificationEnabled = myJsonMap['notification'] ?? true;

    if (type != null && (id == null || id.isEmpty)) {
      id = SmeupUtilities.getWidgetId(myJsonMap['type'], myJsonMap['id']);

      optionsDefault = _getNewLinkedHashMap();
      options = _getNewLinkedHashMap();
      optionsType = _getNewLinkedHashMap();

      if (myJsonMap['options'] != null) {
        _setLinkedHashMap(myJsonMap['options'], options);

        if (myJsonMap['options'][type] != null) {
          _setLinkedHashMap(myJsonMap['options'][type], optionsType);

          if (myJsonMap['options'][type]['default'] != null) {
            _setLinkedHashMap(
                myJsonMap['options'][type]['default'], optionsDefault);
          }
        }
      }
    }

    data = myJsonMap['data'];
  }

  LinkedHashMap<String, dynamic> _getNewLinkedHashMap() {
    return LinkedHashMap<String, dynamic>(
        equals: (a, b) => a.toLowerCase() == b.toLowerCase(),
        hashCode: (key) => key.toLowerCase().hashCode);
  }

  _setLinkedHashMap(
      Map<String, dynamic> map, LinkedHashMap<String, dynamic> linkedHashMap) {
    map.entries.forEach((element) {
      linkedHashMap[element.key] = element.value;
    });
  }
}
