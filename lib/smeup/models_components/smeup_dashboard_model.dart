import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_component_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDashboardModel extends SmeupComponentModel
    implements SmeupDataInterface {
  static const double defaultFontsize = 60.0;
  static const double defaultLabelFontsize = 10.0;
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const double defaultIconSize = 40.0;

  String valueColName = '';
  String forceText = '';
  int forceValue = 0;
  int forceIcon = 0;
  Color iconColor;
  String selectLayout = '';
  double fontsize;
  double labelFontsize;
  double width;
  double height;
  double iconSize;

  SmeupDashboardModel(
      {this.valueColName = '',
      this.forceText = '',
      this.forceValue,
      this.forceIcon,
      this.iconColor,
      this.selectLayout,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.fontsize = defaultFontsize,
      this.labelFontsize = defaultLabelFontsize,
      this.iconSize = defaultIconSize,
      title = ''})
      : super(title: title) {
    if (iconColor == null) iconColor = SmeupOptions.theme.iconTheme.color;
    id = 'DSH' + Random().nextInt(100).toString();
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupDashboardModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
    valueColName = optionsDefault['valueColName'] ?? '';
    forceText = optionsDefault['forceText'] ?? '';
    forceValue = optionsDefault['forceValue'] ?? 0;
    width = getDouble(optionsDefault['width']) ?? defaultWidth;
    height = getDouble(optionsDefault['height']) ?? defaultHeight;
    fontsize = getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    iconSize = getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    labelFontsize =
        getDouble(optionsDefault['labelFontSize']) ?? defaultLabelFontsize;
    if (optionsDefault['forceIcon'] != null)
      forceIcon = int.tryParse(optionsDefault['forceIcon']) ?? 0;
    else
      forceIcon = 0;

    if (optionsDefault['iconColor'] != null) {
      iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']);
    }
    selectLayout = optionsDefault['selectLayout'] ?? '';
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
      SmeupDynamismService.storeDynamicVariables(data['rows'][0]);
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
