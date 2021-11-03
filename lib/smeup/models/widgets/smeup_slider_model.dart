import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_slider_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupSliderModel extends SmeupModel {
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 10, right: 10);
  static const double defaultSldMin = 0;
  static const double defaultSldMax = 100;

  EdgeInsetsGeometry padding;
  double sldMin;
  double sldMax;

  SmeupSliderModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    this.padding = defaultPadding,
    this.sldMin = defaultSldMin,
    this.sldMax = defaultSldMax,
  }) : super(formKey, title: '', id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'sld';
    id = SmeupUtilities.getWidgetId('FLD', id);
  }

  SmeupSliderModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    sldMin =
        SmeupUtilities.getDouble(optionsDefault['sldMin']) ?? defaultSldMin;
    sldMax =
        SmeupUtilities.getDouble(optionsDefault['sldMax']) ?? defaultSldMax;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupSliderDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
