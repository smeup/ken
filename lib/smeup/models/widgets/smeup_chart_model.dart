import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupChartModel extends SmeupModel {
  SmeupChartModel({title = ''}) : super(title: title) {
    id = SmeupUtilities.getWidgetId('CHA', id);
  }

  SmeupChartModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap);
}
