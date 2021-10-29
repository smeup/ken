import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_inputpanel_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/input_panel/smeup_input_panel_field.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupInputPanelModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontSize = 16.0;

  EdgeInsetsGeometry padding;
  double fontSize;
  double iconSize;

  List<SmeupInputPanelField> fields;

  SmeupInputPanelModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    title = '',
    this.padding = defaultPadding,
    this.fontSize = defaultFontSize,
  }) : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupInputPanelModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;

    title = jsonMap['title'] == null || jsonMap['title'] == '*NONE'
        ? ''
        : jsonMap['title'];

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupInputPanelDao.getData(this, formKey);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
