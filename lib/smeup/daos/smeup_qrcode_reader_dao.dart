import 'dart:async';

import 'package:ken/smeup/models/widgets/smeup_qrcode_reader_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';

import 'smeup_dao.dart';

class SmeupQRCodeReaderDao extends SmeupDao {
  static Future<void> getData(SmeupQRCodeReaderModel model) async {
    if (model.smeupFun != null && model.smeupFun!.isFunValid()) {
      final smeupServiceResponse =
          await SmeupDataService.invoke(model.smeupFun);

      if (!smeupServiceResponse.succeded) {
        SmeupDataService.decrementDataFetch(model.id);
        return;
      }

      var data = smeupServiceResponse.result.data;

      if (model.onDataRead != null) model.onDataRead!(data);

      model.data = data;

      SmeupDataService.decrementDataFetch(model.id);
    }
  }
}

String? encodedText(Map data) {
  return data['rows'][0]['QRC'];
}
