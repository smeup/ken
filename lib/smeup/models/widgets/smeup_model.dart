import 'dart:math';

import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

abstract class SmeupModel {
  static const int defaultRefresh = 0;

  dynamic jsonMap;
  dynamic data;
  String type;
  String id;
  SmeupFun smeupFun;
  String load = '';
  Map<String, dynamic> options;
  dynamic optionsType;
  Map<String, dynamic> optionsDefault;
  String title = '';
  String layout = '';
  dynamic dynamisms;
  bool showLoader = false;
  bool notificationEnabled = true;
  bool isNotified = false;
  int serviceStatusCode = 0;
  int refresh;

  SmeupModel({this.title}) {
    showLoader = SmeupOptions.showLoader;
  }

  SmeupModel.fromMap(Map<String, dynamic> jsonMap) {
    this.jsonMap = jsonMap;
    type = jsonMap['type'];
    dynamisms = jsonMap['dynamisms'];
    if (type != null) {
      id = jsonMap['id'] ?? jsonMap['type'] + Random().nextInt(100).toString();

      smeupFun = SmeupFun(jsonMap['fun']);
      load = jsonMap['load'] ?? '';

      options = jsonMap['options'] ?? Map<String, dynamic>();

      if (options[jsonMap['type']] == null)
        options[jsonMap['type']] = Map<String, dynamic>();

      optionsType = options[jsonMap['type']];

      if (optionsType['default'] == null)
        optionsType['default'] = Map<String, dynamic>();

      optionsDefault = optionsType['default'] ?? Map<String, dynamic>();
      showLoader = jsonMap['showLoader'] ?? SmeupOptions.showLoader;
      notificationEnabled = jsonMap['notification'] ?? true;
      refresh = getInt(optionsDefault['refresh']) ?? defaultRefresh;
    }
  }

  bool hasData() {
    return data != null;
  }

  int getInt(dynamic value) {
    if (value is int) {
      return value;
    } else if (value is String) {
      return int.tryParse(value);
    }
    return value;
  }
}
