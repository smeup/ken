import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenImageModel extends KenModel implements KenDataInterface {
  static const double defaultWidth = 300;
  static const double defaultHeight = 300;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultIsRemote = false;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;

  KenImageModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
    title = '',
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type);

  KenImageModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context) {
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await this.getData();
        // await SmeupImageDao.getData(this);
      };
    }
  }
}
