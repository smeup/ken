import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupCaurouselModel extends SmeupModel implements SmeupDataInterface {
  List<Map> clientData;
  static const double defaultHeight = 100;

  bool autoPlay;
  double height;

  SmeupCaurouselModel(
      {this.clientData,
      this.height = defaultHeight,
      this.autoPlay = false,
      title = ''})
      : super(title: title) {
    id = SmeupUtilities.getWidgetId('CAU', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupCaurouselModel.fromMap(Map jsonMap) : super.fromMap(jsonMap) {
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    autoPlay = optionsDefault['autoPlay'] ?? false;
    SmeupDataService.incrementDataFetch(id);
  }

  @override
  // ignore: override_on_non_overriding_member
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }
      data = smeupServiceResponse.result.data;
    }

    if (data == null && clientData != null) {
      data = clientData;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}

class SmeupCaurouselModelIndicator with ChangeNotifier {
  int index;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}
