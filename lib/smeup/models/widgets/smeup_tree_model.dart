import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTreeModel extends SmeupModel implements SmeupDataInterface {
  dynamic clientData;

  SmeupTreeModel(GlobalKey<FormState> formKey, {this.clientData, title = ''})
      : super(formKey, title: title) {
    id = SmeupUtilities.getWidgetId('TRE', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTreeModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  // ignore: override_on_non_overriding_member
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
