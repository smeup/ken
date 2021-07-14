import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model_mixin.dart';

class SmeupComponentModel extends SmeupModel with SmeupModelMixin {
  SmeupComponentModel({title}) : super(title: title);

  SmeupComponentModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap);
}
