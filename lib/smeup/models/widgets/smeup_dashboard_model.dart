import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_dashboard_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDashboardModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontsize = 60.0;
  static const double defaultLabelFontsize = 10.0;
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const double defaultIconSize = 40.0;
  static const String defaultValueColName = 'value';
  static const String defaultSelectLayout = '';

  EdgeInsetsGeometry padding;
  String valueColName;
  Color iconColor;
  String selectLayout;
  double fontsize;
  double labelFontsize;
  double width;
  double height;
  double iconSize;

  SmeupDashboardModel(
      {id,
      type,
      formKey,
      this.valueColName = defaultValueColName,
      this.padding = defaultPadding,
      this.iconColor,
      this.selectLayout = defaultSelectLayout,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.fontsize = defaultFontsize,
      this.labelFontsize = defaultLabelFontsize,
      this.iconSize = defaultIconSize,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    if (iconColor == null)
      iconColor = SmeupConfigurationService.getTheme().iconTheme.color;
    id = SmeupUtilities.getWidgetId('DSH', id);
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupDashboardModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    valueColName = optionsDefault['valueColName'] ?? defaultValueColName;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    fontsize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontsize;
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    labelFontsize = SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
        defaultLabelFontsize;
    if (optionsDefault['iconColor'] != null) {
      iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']);
    }
    selectLayout = optionsDefault['selectLayout'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      SmeupDashboardDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
