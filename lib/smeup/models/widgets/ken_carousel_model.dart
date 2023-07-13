import 'package:flutter/material.dart';

import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenCarouselModel extends KenModel implements KenDataInterface {
  static const double defaultHeight = 300;

  bool? autoPlay;
  double? height;

  KenCarouselModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.height = defaultHeight,
    this.autoPlay = false,
    title = '',
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,);

  KenCarouselModel.fromMap(
      Map jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context) {
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    autoPlay = optionsDefault!['autoPlay'] ?? false;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await this.getData();
        // await SmeupCarouselDao.getData(this);
      };
    }
  }
}
