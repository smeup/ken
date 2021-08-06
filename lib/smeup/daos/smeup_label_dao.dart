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

      var newList = List.empty(growable: true);
      (smeupServiceResponse.result.data['rows'] as List).forEach((element) {
        var newEl = {
          "value": element[model.optionsDefault['valueColName']],
          model.optionsDefault['iconColName']:
              element[model.optionsDefault['iconColName']],
          if (model.colorColName != null && model.colorColName.isNotEmpty)
            model.optionsDefault['colorColName']:
                SmeupUtilities.getColorFromRGB(
                    element[model.optionsDefault['colorColName']]),
          if (model.colorFontColName != null &&
              model.colorFontColName.isNotEmpty)
            model.optionsDefault['colorFontColName']:
                SmeupUtilities.getColorFromRGB(
                    element[model.optionsDefault['colorFontColName']]),
        };
        newList.add(newEl);
      });

      model.data = newList;
    }

    if (model.data == null && model.clientData != null) {
      model.data = model.clientData;
      model.data = SmeupDao.getClientDataStructure(model);
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
