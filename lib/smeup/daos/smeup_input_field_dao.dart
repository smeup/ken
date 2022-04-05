import 'package:ken/smeup/models/widgets/smeup_input_field_model.dart';

import '../services/smeup_data_service.dart';

class SmeupInputFieldDao {
  static Future<void> getValidation(SmeupInputFieldModel model) async {
    if (model.validationFun != null && model.validationFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.validationFun);
      if (!smeupServiceResponse.succeded) {
        return;
      }
      model.validation =
          smeupServiceResponse.result.data['rows'][0][model.validationField];
    }
  }
}
