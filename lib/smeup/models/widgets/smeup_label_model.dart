import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_label_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupLabelModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontSize = 16.0;
  static const double defaultIconSize = 16.0;
  static const Alignment defaultAlign = Alignment.center;
  static const bool defaultFontbold = false;
  static const double defaultWidth = 0;
  static const double defaultHeight = 40;
  static const String defaultValColName = 'value';

  EdgeInsetsGeometry padding;
  double fontSize;
  double iconSize;
  Alignment align;
  bool fontbold;
  double width;
  double height;
  String valueColName;
  String colorColName;
  String colorFontColName;
  int iconData;
  String iconColname;
  Color backColor;
  Color fontColor;

  SmeupLabelModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.valueColName = defaultValColName,
      this.padding = defaultPadding,
      this.fontSize = defaultFontSize,
      this.align = defaultAlign,
      this.fontbold = defaultFontbold,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.colorColName = '',
      this.backColor,
      this.fontColor,
      this.iconData = 0,
      this.iconColname = '',
      this.colorFontColName = '',
      this.iconSize = defaultIconSize,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupLabelModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    if (fontColor == null)
      fontColor =
          SmeupConfigurationService.getTheme().textTheme.bodyText1.color;

    valueColName = optionsDefault['valueColName'] ?? defaultValColName;
    colorColName = optionsDefault['colorColName'] ?? '';
    colorFontColName = optionsDefault['colorFontColName'] ?? '';
    padding = SmeupUtilities.getPadding(optionsDefault['padding']);
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']);
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    title = jsonMap['title'] ?? '';
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }
    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }
    if (optionsDefault['icon'] != null)
      iconData = int.tryParse(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    iconColname = optionsDefault['iconColName'] ?? '';
    if (optionsDefault['fontBold'] == null) {
      fontbold = defaultFontbold;
    } else {
      if (optionsDefault['fontBold'] is bool)
        fontbold = optionsDefault['fontBold'];
      else if (optionsDefault['fontBold'] == 'Yes')
        fontbold = true;
      else
        fontbold = false;
    }

    if (widgetLoadType != LoadType.Delay) {
      SmeupLabelDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
