import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTreeModel extends SmeupModel implements SmeupDataInterface {
  SmeupTreeModel(GlobalKey<FormState> formKey, {title = ''})
      : super(formKey, title: title) {
    id = SmeupUtilities.getWidgetId('TRE', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTreeModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    SmeupDataService.incrementDataFetch(id);
  }
}
