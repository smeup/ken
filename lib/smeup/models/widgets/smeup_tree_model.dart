import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_tree_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTreeModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 100;
  static const double defaultHeight = 0;

  double width;
  double height;

  SmeupTreeModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    title = '',
    this.width = defaultWidth,
    this.height = defaultHeight,
  }) : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTreeModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    if (widgetLoadType != LoadType.Delay) {
      SmeupTreeDao.getData(this);
    }
    SmeupDataService.incrementDataFetch(id);
  }
}
