import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

import 'smeup_dao.dart';

class SmeupLabelDao extends SmeupDao {
  static Future<dynamic> getData(SmeupLabelModel smeupLabelModel) async {
    dynamic data = smeupLabelModel.data;

    if (smeupLabelModel.smeupFun != null &&
        smeupLabelModel.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(smeupLabelModel.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(smeupLabelModel.id);
        return data;
      }

      var newList = List.empty(growable: true);
      (smeupServiceResponse.result.data['rows'] as List).forEach((element) {
        var newEl = {
          "value": element[smeupLabelModel.optionsDefault['valueColName']],
          smeupLabelModel.optionsDefault['iconColName']:
              element[smeupLabelModel.optionsDefault['iconColName']],
          if (smeupLabelModel.colorColName != null &&
              smeupLabelModel.colorColName.isNotEmpty)
            smeupLabelModel.optionsDefault['colorColName']:
                SmeupUtilities.getColorFromRGB(
                    element[smeupLabelModel.optionsDefault['colorColName']]),
          if (smeupLabelModel.colorFontColName != null &&
              smeupLabelModel.colorFontColName.isNotEmpty)
            smeupLabelModel.optionsDefault['colorFontColName']:
                SmeupUtilities.getColorFromRGB(element[
                    smeupLabelModel.optionsDefault['colorFontColName']]),
        };
        newList.add(newEl);
      });

      data = newList;
    }

    if (data == null && smeupLabelModel.clientData != null) {
      data = smeupLabelModel.clientData;
    }

    SmeupDataService.decrementDataFetch(smeupLabelModel.id);
    return data;
  }
}
