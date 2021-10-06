import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_switch_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupSwitchModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 100;
  static const double defaultHeight = 50;
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultFontsize = 16.0;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double width;
  double height;
  double fontsize;
  EdgeInsetsGeometry padding;
  String text;

  SmeupSwitchModel({
    GlobalKey<FormState> formKey,
    id,
    type,
    title = '',
    this.text = '',
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.fontsize = defaultFontsize,
    this.padding = defaultPadding,
  }) : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'swt';

    SmeupDataService.incrementDataFetch(id);
  }

  SmeupSwitchModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;

    if (widgetLoadType != LoadType.Delay) {
      SmeupSwitchDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
