import 'dart:math';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupQRCodeReaderModel extends SmeupComponentModel
    implements SmeupDataInterface {
  static const double defaultPadding = 5.0;
  static const double defaultSize = 200;

  double padding;
  double size;
  dynamic clientData;
  Function onDataRead;
  int maxReads;
  int delayInMillis;

  SmeupQRCodeReaderModel(
      {this.padding = defaultPadding,
      this.size = defaultSize,
      this.clientData,
      title = '',
      this.onDataRead,
      this.maxReads = 1,
      this.delayInMillis = 0})
      : super(title: title) {
    id = 'FLD' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupQRCodeReaderModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    size = SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultSize;
    title = jsonMap['title'] ?? '';

    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      var count = 0;
      bool failed = true;
      var smeupServiceResponse;
      while (failed) {
        count++;
        smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

        if (!smeupServiceResponse.succeded) {
          if (count == maxReads) {
            return;
          } else {
            await new Future.delayed(new Duration(milliseconds: delayInMillis));
          }
        } else {
          failed = false;
        }
      }

      data = smeupServiceResponse.result.data;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }

    if (onDataRead != null) onDataRead(encodedText);

    SmeupDataService.decrementDataFetch(id);
  }

  String get encodedText {
    if (data != null) {
      return data['rows'][0]['QRC'];
    } else {
      return null;
    }
  }
}
