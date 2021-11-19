import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_combo_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupComboModel extends SmeupModel implements SmeupDataInterface {
  static const String defaultValueField = 'value';
  static const String defaultDescriptionField = 'description';
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const String defaultLabel = '';
  static const double defaultFontSize = 16.0;
  static const double defaultIconSize = 16.0;
  static const Color defaultFontColor = Colors.black87;

  String valueField;
  String descriptionField;
  String selectedValue;
  String label;
  EdgeInsetsGeometry padding;
  double fontSize;
  double iconSize;
  Color fontColor;

  SmeupComboModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.valueField = defaultValueField,
      this.descriptionField = defaultDescriptionField,
      this.padding = defaultPadding,
      this.selectedValue = '',
      this.fontColor = defaultFontColor,
      this.fontSize = defaultFontSize,
      this.iconSize = defaultIconSize,
      this.label = defaultLabel,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'cmb';
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupComboModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    title = jsonMap['title'] ?? '';

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    descriptionField =
        optionsDefault['descriptionField'] ?? defaultDescriptionField;
    selectedValue = optionsDefault['defaultValue'] ?? '';
    label = optionsDefault['label'] ?? defaultLabel;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupComboDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
