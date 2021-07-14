import 'dart:math';

import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupWidgetMixin {
  runControllerActivities() {
    // print('setUIProperties in mixin');
  }

  SmeupModel parseCommonProperties(SmeupModel model) {
    //this.jsonMap = jsonMap;
    //type = model.jsonMap['type'];
    model.dynamisms = model.jsonMap['dynamisms'];
    if (model.type != null && model.id.isEmpty) {
      model.id = model.jsonMap['id'] ??
          model.jsonMap['type'] + Random().nextInt(100).toString();

      model.smeupFun = SmeupFun(model.jsonMap['fun']);
      model.load = model.jsonMap['load'] ?? '';

      model.options = model.jsonMap['options'] ?? Map<String, dynamic>();

      if (model.options[model.jsonMap['type']] == null)
        model.options[model.jsonMap['type']] = Map<String, dynamic>();

      model.optionsType = model.options[model.jsonMap['type']];

      if (model.optionsType['default'] == null)
        model.optionsType['default'] = Map<String, dynamic>();

      model.optionsDefault =
          model.optionsType['default'] ?? Map<String, dynamic>();
      model.showLoader = model.jsonMap['showLoader'] ?? SmeupOptions.showLoader;
      model.notificationEnabled = model.jsonMap['notification'] ?? true;
      model.refresh = SmeupUtilities.getInt(model.optionsDefault['refresh']) ??
          SmeupModel.defaultRefresh;
    }

    model.loaded = model.jsonMap['loaded'];
    model.data = model.jsonMap['data'];
    model.layout = model.jsonMap['layout'];

    return model;
  }
}
