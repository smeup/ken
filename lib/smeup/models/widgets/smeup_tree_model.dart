import 'dart:math';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

class SmeupTreeModel extends SmeupModel implements SmeupDataInterface {
  dynamic clientData;

  SmeupTreeModel({this.clientData, title = ''}) : super(title: title) {
    id = 'TRE' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTreeModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }
      data = smeupServiceResponse.result.data;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
