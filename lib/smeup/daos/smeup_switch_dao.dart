import 'package:mobile_components_library/smeup/models/widgets/smeup_switch_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupSwitchDao extends SmeupDao {
  static Future<void> getData(SmeupSwitchModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      model.data = smeupServiceResponse.result.data;
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
