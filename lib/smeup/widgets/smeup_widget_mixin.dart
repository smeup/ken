import 'dart:math';

import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';

class SmeupWidgetMixin {
  runControllerActivities(SmeupModel model) {
    // print('setUIProperties in mixin');
  }

  String setId(String type, String id) {
    return type != null && (id == null || id.isEmpty)
        ? type + Random().nextInt(100).toString()
        : id;
  }
}
