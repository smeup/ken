import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupListBoxDao extends SmeupDao {
  static Future<dynamic> getData(SmeupListBoxModel smeupListBoxModel) async {
    dynamic data = smeupListBoxModel.data;

    if (smeupListBoxModel.smeupFun != null &&
        smeupListBoxModel.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(smeupListBoxModel.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(smeupListBoxModel.id);
        return data;
      }

      data = smeupServiceResponse.result.data;
    }

    SmeupDataService.decrementDataFetch(smeupListBoxModel.id);
    return data;
  }
}
