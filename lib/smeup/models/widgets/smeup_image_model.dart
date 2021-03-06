import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_image_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupImageModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 40;
  static const double defaultHeight = 40;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultIsRemote = false;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;

  SmeupImageModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupImageModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    padding =
        SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupImageDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
