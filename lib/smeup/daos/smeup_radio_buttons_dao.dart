import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupRadioButtonsDao extends SmeupDao {
  static Future<void> getData(SmeupRadioButtonsModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      model.data = smeupServiceResponse.result.data['rows'];
      if ((model.data as List).length > 0) {
        if (model.valueField.isNotEmpty) {
          model.clientData = model.data[0][model.valueField];
        } else {
          model.clientData = (model.data[0] as Node).label;
        }
      }
    } else if (model.data != null) {
      model.clientData = model.data[0]['value'];
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
