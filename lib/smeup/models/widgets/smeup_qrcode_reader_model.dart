import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_qrcode_reader_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

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
      {this.padding = defaultPadding,
      this.size = defaultSize,
      title = '',
      this.onDataRead,
      this.maxReads = defaultMaxReads,
      this.delayInMillis = defaultDealyInMillis})
      : super(formKey, title: title) {
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupQRCodeReaderModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    size = SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultSize;
    title = jsonMap['title'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      SmeupQRCodeReaderDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
