import 'package:mobile_components_library/smeup/models/widgets/smeup_carousel_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupCarouselDao extends SmeupDao {
  static Future<void> getData(SmeupCarouselModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return;
      }

      model.data = smeupServiceResponse.result.data;

      SmeupDataService.decrementDataFetch(model.id);
    }
  }
}
