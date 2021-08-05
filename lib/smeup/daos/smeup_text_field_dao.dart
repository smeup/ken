import 'package:mobile_components_library/smeup/models/widgets/smeup_text_field_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupTextFieldDao extends SmeupDao {
  static Future<dynamic> getData(SmeupTextFieldModel smeupLabelModel) async {
    dynamic data = smeupLabelModel.data;

    if (smeupLabelModel.smeupFun != null &&
        smeupLabelModel.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(smeupLabelModel.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(smeupLabelModel.id);
        return data;
      }

      data = smeupServiceResponse.result.data;
    }

    if (data == null && smeupLabelModel.clientData != null) {
      data = smeupLabelModel.clientData;
    }

    SmeupDataService.decrementDataFetch(smeupLabelModel.id);
    return data;
  }
}
