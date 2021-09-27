import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupDatePickerDao extends SmeupDao {
  static Future<void> getData(SmeupDatePickerModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      model.data = smeupServiceResponse.result.data;
    }

    /*
    if (clientData != null) {
      data = _getClientDataStructure(clientData);
    }
    */

    SmeupDataService.decrementDataFetch(model.id);
  }
}
