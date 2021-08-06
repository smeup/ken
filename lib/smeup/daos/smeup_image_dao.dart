import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupImageDao extends SmeupDao {
  static Future<void> getData(SmeupImageModel model) async {
    if (model.smeupFun != null && model.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return model.data;
      }

      model.data = smeupServiceResponse.result;
    }

    if (model.data == null && model.clientData != null) {
      model.data = model.clientData;
    }

    // data could contain:
    // data['imageLocalPath'] --> for local images (assets/images)
    // data['imageRemotePath'] = data[0]['k'] --> for remote images (url)
    if (model.data is List &&
        model.data.length > 0 &&
        model.data[0]['k'] != null) {
      String obj = model.data[0]['k'];
      List<String> split = obj.split(';');
      if (split.length > 2) {
        String url = split.getRange(2, split.length).join('');
        model.data = Map();
        model.data['imageRemotePath'] = url;
      }
    }

    SmeupDataService.decrementDataFetch(model.id);
  }
}
