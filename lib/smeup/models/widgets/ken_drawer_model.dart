import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_model.dart';

import '../../services/ken_configuration_service.dart';

class KenDrawerModel extends KenModel {
  // supported by json_theme
  static double? defaultTitleFontSize;
  static Color? defaultTitleFontColor;
  static bool? defaultTitleFontBold;

  static double? defaultElementFontSize;
  static Color? defaultElementFontColor;
  static bool? defaultElementFontBold;

  static Color? defaultAppBarBackColor;

  // unsupported by json_theme
  static const double defaultImageWidth = 40;
  static const double defaultImageHeight = 40;
  static const bool defaultShowItemDivider = true;

  double? titleFontSize;
  Color? titleFontColor;
  bool? titleFontBold;
  double? elementFontSize;
  Color? elementFontColor;
  bool? elementFontBold;
  Color? appBarBackColor;
  bool? showItemDivider;

  double? imageWidth;
  double? imageHeight;
  String? imageUrl;

  KenDrawerModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    appBarBackColor ??=
        KenConfigurationService.getTheme()!.appBarTheme.backgroundColor;
    setDefaults(this);
  }

  KenDrawerModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    titleFontSize = KenUtilities.getDouble(optionsDefault!['titleFontSize']) ??
        defaultTitleFontSize;
    titleFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['titleFontColor']) ??
            defaultTitleFontColor;
    titleFontBold = KenUtilities.getBool(optionsDefault!['titleFontBold']) ??
        defaultTitleFontBold;

    elementFontSize =
        KenUtilities.getDouble(optionsDefault!['elementFontSize']) ??
            defaultElementFontSize;
    elementFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['elementFontColor']) ??
            defaultElementFontColor;
    elementFontBold =
        KenUtilities.getBool(optionsDefault!['elementFontBold']) ??
            defaultElementFontBold;

    imageUrl = optionsDefault!['imageUrl'] ?? '';
    imageWidth = KenUtilities.getDouble(optionsDefault!['imageWidth']) ??
        defaultImageWidth;
    imageHeight = KenUtilities.getDouble(optionsDefault!['imageHeight']) ??
        defaultImageHeight;
    appBarBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['appBarBackColor']);

    showItemDivider =
        KenUtilities.getBool(optionsDefault!['showItemDivider']) ??
            defaultShowItemDivider;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupDrawerDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    AppBarTheme appBarTheme = KenConfigurationService.getTheme()!.appBarTheme;

    TextStyle titleStyle = appBarTheme.titleTextStyle!;
    defaultTitleFontSize = titleStyle.fontSize;
    defaultTitleFontColor = titleStyle.color;
    defaultTitleFontBold = titleStyle.fontWeight == FontWeight.bold;

    TextStyle elementStyle = appBarTheme.toolbarTextStyle!;
    defaultElementFontSize = elementStyle.fontSize;
    defaultElementFontColor = elementStyle.color;
    defaultElementFontBold = elementStyle.fontWeight == FontWeight.bold;

    defaultAppBarBackColor = appBarTheme.backgroundColor;

    // ----------------- set properties from default

    obj.titleFontSize ??= KenDrawerModel.defaultTitleFontSize;
    obj.titleFontColor ??= KenDrawerModel.defaultTitleFontColor;
    obj.titleFontBold ??= KenDrawerModel.defaultTitleFontBold;

    obj.elementFontSize ??= KenDrawerModel.defaultElementFontSize;
    obj.elementFontColor ??= KenDrawerModel.defaultElementFontColor;
    obj.elementFontBold ??= KenDrawerModel.defaultElementFontBold;

    obj.appBarBackColor ??= KenDrawerModel.defaultAppBarBackColor;
  }
}
