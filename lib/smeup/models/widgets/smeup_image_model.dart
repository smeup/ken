import 'dart:math';

import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 40;
  static const double defaultHeight = 40;
  static const double defaultPadding = 0.0;

  double width;
  double height;
  double padding;
  double rightPadding;
  double leftPadding;
  double topPadding;
  double bottomPadding;
  dynamic clientData;

  SmeupImageModel(
      {this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.rightPadding = defaultPadding,
      this.leftPadding = defaultPadding,
      this.topPadding = defaultPadding,
      this.bottomPadding = defaultPadding,
      title = '',
      this.clientData})
      : super(title: title) {
    id = 'IMG' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupImageModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    width = SmeupUtilities.getDouble(jsonMap['width']) ?? defaultWidth;
    height = SmeupUtilities.getDouble(jsonMap['height']) ?? defaultHeight;
    padding = SmeupUtilities.getDouble(jsonMap['padding']) ?? defaultPadding;
    rightPadding =
        SmeupUtilities.getDouble(jsonMap['rightPadding']) ?? defaultPadding;
    leftPadding =
        SmeupUtilities.getDouble(jsonMap['leftPadding']) ?? defaultPadding;
    topPadding =
        SmeupUtilities.getDouble(jsonMap['topPadding']) ?? defaultPadding;
    bottomPadding =
        SmeupUtilities.getDouble(jsonMap['bottomPadding']) ?? defaultPadding;
    title = jsonMap['title'] ?? '';
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      data = smeupServiceResponse.result;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }

    // data could contain:
    // data['imageLocalPath'] --> for local images (assets/images)
    // data['imageRemotePath'] = data[0]['k'] --> for remote images (url)
    if (data is List && (data as List).length > 0 && data[0]['k'] != null) {
      String obj = data[0]['k'];
      List<String> split = obj.split(';');
      if (split.length > 2) {
        String url = split.getRange(2, split.length).join('');
        data = Map();
        data['imageRemotePath'] = url;
      }
    }

    SmeupDataService.decrementDataFetch(id);
  }
}
