import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupTextAutocompleteDao extends SmeupDao {
  static Future<dynamic> getData(
      SmeupTextAutocompleteModel smeupLabelModel) async {
    dynamic data = smeupLabelModel.data;

    if (smeupLabelModel.smeupFun != null &&
        smeupLabelModel.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(smeupLabelModel.smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      data = smeupServiceResponse.result.data;
    }

    if (smeupLabelModel.clientData != null) {
      data = SmeupDao.getClientDataStructure(
          smeupLabelModel.clientData, smeupLabelModel.optionsDefault, data);
    }
    SmeupDataService.decrementDataFetch(smeupLabelModel.id);
    return data;
  }
}
