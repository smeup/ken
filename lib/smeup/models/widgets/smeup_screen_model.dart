import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupScreenModel extends SmeupModel implements SmeupDataInterface {
  BuildContext context;
  static const bool defaultIsDialog = false;
  static const bool defaultBackButtonVisible = true;

  bool isDialog;
  bool backButtonVisible;

  SmeupScreenModel(this.context, SmeupFun smeupFun,
      {this.isDialog = defaultIsDialog,
      this.backButtonVisible = defaultBackButtonVisible})
      : super(null) {
    this.smeupFun = smeupFun;
  }

  @override
  // ignore: override_on_non_overriding_member
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

      isDialog = SmeupUtilities.getBool(data['isDialog']) ?? defaultIsDialog;
      backButtonVisible = SmeupUtilities.getBool(data['backButtonVisible']) ??
          defaultBackButtonVisible;

      try {
        serviceStatusCode = smeupServiceResponse.result.statusCode;
      } catch (e) {}
    }
  }
}
