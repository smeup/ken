import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';

class SmeupDao {
  static dynamic getClientDataStructure(dynamic model) {
    switch (model.type) {
      case 'LAB':
        var newList = List.empty(growable: true);
        (model.data as List).forEach((element) {
          newList.add({
            'value': element,
          });
        });
        return newList;
        break;

      case 'FLD':
        switch (model.optionsDefault['type']) {
          case 'itx':
          case 'acp':
            return {
              "rows": [
                {
                  'value': model.data,
                }
              ],
            };

          default:
            return model.data;
        }
        break;

      default:
        return {"rows": model.data};
    }
  }

  static Future<void> getData(SmeupModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);
      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return;
      }
      model.data = smeupServiceResponse.result.data;
    }
    if (!SmeupDataService.isDataStructure(model.data)) {
      dynamic res = SmeupDataService.getEmptyDataStructure();
      res['rows'] = model.data;
      model.data = res;
    }
    SmeupDataService.decrementDataFetch(model.id);
  }
}
