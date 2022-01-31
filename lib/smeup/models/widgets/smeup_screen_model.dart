import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupScreenModel extends SmeupModel implements SmeupDataInterface {
  BuildContext context;
  static const bool defaultIsDialog = false;
  static const bool defaultBackButtonVisible = true;

  bool isDialog;
  bool backButtonVisible;

  SmeupScreenModel(this.context, SmeupFun smeupFun,
      {this.isDialog = defaultIsDialog,
      this.backButtonVisible = defaultBackButtonVisible})
      : super(null, null, null) {
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

      if (data['isDialog'] != null)
        isDialog = SmeupUtilities.getBool(data['isDialog']);
      if (data['backButtonVisible'] != null)
        backButtonVisible = SmeupUtilities.getBool(data['backButtonVisible']);

      try {
        serviceStatusCode = smeupServiceResponse.result.statusCode;
      } catch (e) {}
    }
  }
}
