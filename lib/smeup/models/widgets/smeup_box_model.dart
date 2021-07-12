import 'dart:math';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupBoxModel extends SmeupComponentModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const double defaultFontsize = 16.0;
  static const String defaultLayout = '1';

  double width;
  double height;
  double fontsize;
  String layout;
  List<dynamic> clientColumns;
  //Function clientOnTap;
  dynamic clientRow;

  SmeupBoxModel(
      {this.fontsize = defaultFontsize,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.layout = defaultLayout,
      this.clientColumns,
      title = '',
      this.clientRow})
      : super(title: title) {
    id = 'BOX' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupBoxModel.fromMap(Map<String, dynamic> jsonMap) : super.fromMap(jsonMap) {
    fontsize = optionsDefault['fontSize'] ?? defaultFontsize;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    layout =
        SmeupUtilities.getDouble(optionsDefault['layout']) ?? defaultLayout;
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

      data = smeupServiceResponse.result.data;
    }

    if (data == null && clientRow != null) {
      data = clientRow;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
