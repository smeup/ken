import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';

class SmeupScreenModel extends SmeupModel implements SmeupDataInterface {
  BuildContext context;

  SmeupScreenModel(this.context, SmeupFun smeupFun) {
    this.smeupFun = smeupFun;
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        try {
          serviceStatusCode = smeupServiceResponse.result.statusCode;
        } catch (e) {}
        return;
      }

      data = smeupServiceResponse.result.data;
      try {
        serviceStatusCode = smeupServiceResponse.result.statusCode;
      } catch (e) {}
    }
  }
}
