import 'dart:math';

import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';

class SmeupChartModel extends SmeupModel {
  SmeupChartModel({title = ''}) : super(title: title) {
    id = 'CHA' + Random().nextInt(100).toString();
  }

  SmeupChartModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap);
}
