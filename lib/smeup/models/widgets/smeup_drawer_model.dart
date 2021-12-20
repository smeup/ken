import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_drawer_dao.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupDrawerModel extends SmeupModel {
  // supported by json_theme
  static double defaultTitleFontSize;
  static Color defaultTitleFontColor;
  static bool defaultTitleFontBold;

  static double defaultElementFontSize;
  static Color defaultElementFontColor;
  static bool defaultElementFontBold;

  static Color defaultAppBarBackColor;

  // unsupported by json_theme
  static const double defaultImageWidth = 40;
  static const double defaultImageHeight = 40;
  static const bool defaultShowItemDivider = true;

  double titleFontSize;
  Color titleFontColor;
  bool titleFontBold;
  double elementFontSize;
  Color elementFontColor;
  bool elementFontBold;
  Color appBarBackColor;
  bool showItemDivider;

  double imageWidth;
  double imageHeight;
  String imageUrl;

  SmeupDrawerModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    this.appBarBackColor,
    this.titleFontSize,
    this.titleFontColor,
    this.titleFontBold,
    this.elementFontSize,
    this.elementFontColor,
    this.elementFontBold,
    title,
    this.imageUrl = '',
    this.imageWidth = defaultImageWidth,
    this.imageHeight = defaultImageHeight,
    this.showItemDivider = defaultShowItemDivider,
  }) : super(formKey, title: title, id: id, type: type) {
    if (appBarBackColor == null)
      appBarBackColor =
          SmeupConfigurationService.getTheme().appBarTheme.backgroundColor;
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupDrawerModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    titleFontSize = SmeupUtilities.getDouble(optionsDefault['titleFontSize']) ??
        defaultTitleFontSize;
    titleFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['titleFontColor']) ??
            defaultTitleFontColor;
    titleFontBold = SmeupUtilities.getBool(optionsDefault['titleFontBold']) ??
        defaultTitleFontBold;

    elementFontSize =
        SmeupUtilities.getDouble(optionsDefault['elementFontSize']) ??
            defaultElementFontSize;
    elementFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['elementFontColor']) ??
            defaultElementFontColor;
    elementFontBold =
        SmeupUtilities.getBool(optionsDefault['elementFontBold']) ??
            defaultElementFontBold;

    imageUrl = optionsDefault['imageUrl'] ?? '';
    imageWidth = SmeupUtilities.getDouble(optionsDefault['imageWidth']) ??
        defaultImageWidth;
    imageHeight = SmeupUtilities.getDouble(optionsDefault['imageHeight']) ??
        defaultImageHeight;
    appBarBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['appBarBackColor']);

    showItemDivider =
        SmeupUtilities.getBool(optionsDefault['showItemDivider']) ??
            defaultShowItemDivider;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupDrawerDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    AppBarTheme appBarTheme = SmeupConfigurationService.getTheme().appBarTheme;

    TextStyle titleStyle = appBarTheme.titleTextStyle;
    defaultTitleFontSize = titleStyle.fontSize;
    defaultTitleFontColor = titleStyle.color;
    defaultTitleFontBold = titleStyle.fontWeight == FontWeight.bold;

    TextStyle elementStyle = appBarTheme.toolbarTextStyle;
    defaultElementFontSize = elementStyle.fontSize;
    defaultElementFontColor = elementStyle.color;
    defaultElementFontBold = elementStyle.fontWeight == FontWeight.bold;

    defaultAppBarBackColor = appBarTheme.backgroundColor;

    // ----------------- set properties from default

    if (obj.titleFontSize == null)
      obj.titleFontSize = SmeupDrawerModel.defaultTitleFontSize;
    if (obj.titleFontColor == null)
      obj.titleFontColor = SmeupDrawerModel.defaultTitleFontColor;
    if (obj.titleFontBold == null)
      obj.titleFontBold = SmeupDrawerModel.defaultTitleFontBold;

    if (obj.elementFontSize == null)
      obj.elementFontSize = SmeupDrawerModel.defaultElementFontSize;
    if (obj.elementFontColor == null)
      obj.elementFontColor = SmeupDrawerModel.defaultElementFontColor;
    if (obj.elementFontBold == null)
      obj.elementFontBold = SmeupDrawerModel.defaultElementFontBold;

    if (obj.appBarBackColor == null)
      obj.appBarBackColor = SmeupDrawerModel.defaultAppBarBackColor;
  }
}
