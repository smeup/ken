import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupImageDao extends SmeupDao {
  static Future<void> getData(SmeupImageModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return model.data;
      }

      model.data = smeupServiceResponse.result;
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
