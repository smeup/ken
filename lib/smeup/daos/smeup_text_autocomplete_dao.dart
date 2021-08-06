import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupTextAutocompleteDao extends SmeupDao {
  static Future<void> getData(SmeupTextAutocompleteModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      model.data = smeupServiceResponse.result.data;
    }

    if (model.clientData != null) {
      model.data = SmeupDao.getClientDataStructure(model);
    }
    SmeupDataService.decrementDataFetch(model.id);
  }
}
