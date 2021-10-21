import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupInputPanelModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  EdgeInsetsGeometry padding;

  SmeupInputPanelModel({id, type, GlobalKey<FormState> formKey, title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupInputPanelModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    padding = SmeupUtilities.getPadding(optionsDefault['padding']);

    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      SmeupInputPanelDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
