import 'package:mobile_components_library/smeup/models/widgets/smeup_image_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupImageDao extends SmeupDao {
  static Future<dynamic> getData(SmeupImageModel smeupImageModel) async {
    dynamic data = smeupImageModel.data;

    if (smeupImageModel.smeupFun != null &&
        smeupImageModel.smeupFun.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(smeupImageModel.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(smeupImageModel.id);
        return data;
      }

      data = smeupServiceResponse.result;
    }

    if (data == null && smeupImageModel.clientData != null) {
      data = smeupImageModel.clientData;
    }

    // data could contain:
    // data['imageLocalPath'] --> for local images (assets/images)
    // data['imageRemotePath'] = data[0]['k'] --> for remote images (url)
    if (data is List && data.length > 0 && data[0]['k'] != null) {
      String obj = data[0]['k'];
      List<String> split = obj.split(';');
      if (split.length > 2) {
        String url = split.getRange(2, split.length).join('');
        data = Map();
        data['imageRemotePath'] = url;
      }
    }

    SmeupDataService.decrementDataFetch(smeupImageModel.id);
    return data;
  }
}
