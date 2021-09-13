// import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupButtonsDao extends SmeupDao {
  static Future<void> getData(SmeupButtonsModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return;
      }

      model.data = smeupServiceResponse.result.data;
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
