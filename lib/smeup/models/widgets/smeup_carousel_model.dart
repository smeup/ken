import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_carousel_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupCarouselModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultHeight = 100;

  bool autoPlay;
  double height;

  SmeupCarouselModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.height = defaultHeight,
      this.autoPlay = false,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupCarouselModel.fromMap(Map jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    autoPlay = optionsDefault['autoPlay'] ?? false;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupCarouselDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
