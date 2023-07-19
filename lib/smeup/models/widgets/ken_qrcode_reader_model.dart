import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_input_field_model.dart';
import 'ken_model.dart';

class KenQRCodeReaderModel extends KenInputFieldModel
    implements KenDataInterface {
  static const double defaultPadding = 5.0;
  static const double defaultSize = 200;
  static const int defaultMaxReads = 1;
  static const int defaultDealyInMillis = 0;

  double? padding;
  double? size;
  Function? onDataRead;
  int? maxReads;
  int? delayInMillis;

  KenQRCodeReaderModel(
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context, {
    this.padding = defaultPadding,
    this.size = defaultSize,
    title = '',
    this.onDataRead,
    this.maxReads = defaultMaxReads,
    this.delayInMillis = defaultDealyInMillis,
  }) : super(formKey, scaffoldKey, context, title: title) {
    id = KenUtilities.getWidgetId('FLD', id);
  }

  KenQRCodeReaderModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      KenModel parent)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, parent) {
    padding =
        KenUtilities.getDouble(optionsDefault!['padding']) ?? defaultPadding;
    size = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultSize;
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await getData();
        // await SmeupQRCodeReaderDao.getData(this);
      };
    }
  }
}
