import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_qrcode_reader_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupQRCodeReaderModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultPadding = 5.0;
  static const double defaultSize = 200;
  static const int defaultMaxReads = 1;
  static const int defaultDealyInMillis = 0;

  double padding;
  double size;
  Function onDataRead;
  int maxReads;
  int delayInMillis;

  SmeupQRCodeReaderModel(GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext context,
      {this.padding = defaultPadding,
      this.size = defaultSize,
      title = '',
      this.onDataRead,
      this.maxReads = defaultMaxReads,
      this.delayInMillis = defaultDealyInMillis})
      : super(formKey, scaffoldKey, context, title: title) {
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupQRCodeReaderModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    size = SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultSize;
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupQRCodeReaderDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
