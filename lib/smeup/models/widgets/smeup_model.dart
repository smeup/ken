import 'dart:math';

import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

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

  bool loaded = false;

  List<SmeupSectionModel> smeupSectionsModels;

  SmeupModel({this.title}) {
    showLoader = SmeupOptions.showLoader;
  }

  SmeupModel.fromMap(Map<String, dynamic> jsonMap) {
    this.jsonMap = jsonMap;
    type = jsonMap['type'];
    dynamisms = jsonMap['dynamisms'];

    if (type != null && (id == null || id.isEmpty)) {
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
      refresh =
          SmeupUtilities.getInt(optionsDefault['refresh']) ?? defaultRefresh;
    }

    loaded = jsonMap['loaded'];

    data = jsonMap['data'];

    layout = jsonMap['layout'];
  }
}
