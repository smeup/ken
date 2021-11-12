import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_dashboard_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDashboardModel extends SmeupModel implements SmeupDataInterface {
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultFontsize = 56.0;
  static const double defaultLabelFontsize = 10.0;
  static const double defaultWidth = 120;
  static const double defaultHeight = 120;
  static const double defaultIconSize = 40.0;
  static const String defaultValueColName = 'value';
  static const String defaultIconColName = 'icon';
  static const String defaultTextColName = 'description';
  static const String defaultUmColName = 'um';
  static const String defaultSelectLayout = '';
  static const String defaultForceText = '';
  static const String defaultForceIcon = '';
  static const String defaultForceValue = '';
  static const String defaultForceUm = '';

  EdgeInsetsGeometry padding;
  String valueColName;
  String iconColName;
  String umColName;
  String textColName;
  String forceText;
  String forceUm;
  String forceValue;
  String forceIcon;
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
      this.umColName = defaultUmColName,
      this.textColName = defaultTextColName,
      this.iconColName = defaultIconColName,
      this.padding = defaultPadding,
      this.iconColor,
      this.selectLayout = defaultSelectLayout,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.fontsize = defaultFontsize,
      this.labelFontsize = defaultLabelFontsize,
      this.iconSize = defaultIconSize,
      this.forceText = defaultForceText,
      this.forceValue = defaultForceValue,
      this.forceUm = defaultForceUm,
      this.forceIcon = defaultForceIcon,
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
    valueColName = optionsDefault['ValueColName'] ?? defaultValueColName;
    iconColName = optionsDefault['iconColName'] ?? defaultIconColName;
    textColName = optionsDefault['textColName'] ?? defaultTextColName;
    umColName = optionsDefault['umColName'] ?? defaultUmColName;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    double perc = SmeupUtilities.getDouble(
            optionsDefault['FontSize'].toString().replaceAll("%", "")) ??
        defaultFontsize;
    fontsize = defaultFontsize * perc / 100;
    iconSize = SmeupUtilities.getDouble(optionsDefault['iconSize']) ??
        defaultIconSize * perc / 100;
    labelFontsize = SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
        defaultLabelFontsize * perc / 100;
    if (optionsDefault['iconColor'] != null) {
      iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']);
    }
    selectLayout = optionsDefault['selectLayout'] ?? '';
    forceText = optionsDefault['forceText'] ?? '';
    forceUm = optionsDefault['forceUm'] ?? '';
    forceIcon = optionsDefault['forceIcon'] ?? '';
    forceValue = optionsDefault['forceValue'] ?? '';

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupDashboardDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
