import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_image_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 40;
  static const double defaultHeight = 40;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double width;
  double height;
  EdgeInsetsGeometry padding;

  SmeupImageModel(
      {id,
      type,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      title = ''})
      : super(title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupImageModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    width = SmeupUtilities.getDouble(jsonMap['width']) ?? defaultWidth;
    height = SmeupUtilities.getDouble(jsonMap['height']) ?? defaultHeight;
    padding = SmeupUtilities.getPadding(optionsDefault['padding']);
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      SmeupImageDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
