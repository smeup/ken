import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_carousel_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupCarouselModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultHeight = 100;

  bool? autoPlay;
  double? height;

  SmeupCarouselModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.height = defaultHeight,
      this.autoPlay = false,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupCarouselModel.fromMap(Map jsonMap, GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey, BuildContext? context)
      : super.fromMap(jsonMap as Map<String, dynamic>, formKey, scaffoldKey, context) {
    height =
        SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    autoPlay = optionsDefault!['autoPlay'] ?? false;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupCarouselDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
