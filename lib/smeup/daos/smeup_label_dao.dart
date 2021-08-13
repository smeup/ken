import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

import 'smeup_dao.dart';

class SmeupLabelDao extends SmeupDao {
  static Future<void> getData(SmeupLabelModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return model.data;
      }

      model.data = smeupServiceResponse.result.data;

      var firstElement =
          (smeupServiceResponse.result.data['rows'] as List).first;
      if (firstElement != null) {
        // overrides model properties
        if (firstElement[model.optionsDefault['iconColName']] != null) {
          model.iconData =
              int.tryParse(firstElement[model.optionsDefault['iconColName']]) ??
                  0;
        }

        if (firstElement[model.optionsDefault['colorColName']] != null) {
          model.backColor = SmeupUtilities.getColorFromRGB(
              firstElement[model.optionsDefault['colorColName']]);
        }

        if (firstElement[model.optionsDefault['colorFontColName']] != null) {
          model.fontColor = SmeupUtilities.getColorFromRGB(
              firstElement[model.optionsDefault['colorFontColName']]);
        }
      }
    }

    // if (model.data == null && model.clientData != null) {
    //   model.data = model.clientData;
    //   model.data = SmeupDao.getClientDataStructure(model);
    // }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
