import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupGaugeModel extends SmeupModel implements SmeupDataInterface {
  dynamic clientData;

  SmeupGaugeModel({this.clientData, title = ''}) : super(title: title) {
    id = SmeupUtilities.getWidgetId('GAU', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupGaugeModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
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
