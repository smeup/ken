import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_drawer_dao.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDrawerModel extends SmeupModel {
  static const double defaultImageWidth = 40;
  static const double defaultImageHeight = 40;

  double imageWidth;
  double imageHeight;
  String imageUrl;
  Color navbarBackcolor;

  SmeupDrawerModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      title,
      this.imageUrl = '',
      this.imageWidth = defaultImageWidth,
      this.imageHeight = defaultImageHeight,
      this.navbarBackcolor})
      : super(formKey, title: title, id: id, type: type) {
    if (navbarBackcolor == null)
      navbarBackcolor =
          SmeupConfigurationService.getTheme().appBarTheme.backgroundColor;
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupDrawerModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    imageUrl = optionsDefault['imageUrl'] ?? '';
    imageWidth = SmeupUtilities.getDouble(optionsDefault['imageWidth']) ??
        defaultImageWidth;
    imageHeight = SmeupUtilities.getDouble(optionsDefault['imageHeight']) ??
        defaultImageHeight;
    if (optionsDefault['navbarBackcolor'] != null) {
      navbarBackcolor =
          SmeupUtilities.getColorFromRGB(optionsDefault['navbarBackcolor']);
    }

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupDrawerDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
