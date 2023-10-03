import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_model.dart';

class KenDrawerModel extends KenModel {
  // supported by json_theme
  static const double defaultTitleFontSize = 18;
  static const Color defaultTitleFontColor = KenModel.kPrimary;
  static const bool defaultTitleFontBold = false;
  static const double defaultElementFontSize = 16;
  static const Color defaultElementFontColor = KenModel.kPrimary;
  static const bool defaultElementFontBold = false;
  static const Color defaultAppBarBackColor = KenModel.kPrimary;
  static const double defaultImageWidth = 80;
  static const double defaultImageHeight = 120;
  static const bool defaultShowItemDivider = true;
  static const Color defaultIconColor = KenModel.kPrimary;
  static const double defaultIconSize = 16;
  static const Color defaultDrawerBackColor = KenModel.kSecondary100;

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
  Color? iconColor;
  double? iconSize;
  Color? drawerBackColor;

  KenDrawerModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.appBarBackColor = defaultAppBarBackColor,
    this.titleFontSize = defaultTitleFontSize,
    this.titleFontColor = defaultTitleFontColor,
    this.titleFontBold = defaultTitleFontBold,
    this.elementFontSize = defaultElementFontSize,
    this.elementFontColor = defaultElementFontColor,
    this.elementFontBold = defaultElementFontBold,
    this.iconColor = defaultIconColor,
    this.iconSize = defaultIconSize,
    this.drawerBackColor = defaultDrawerBackColor,
    title,
    this.imageUrl = '',
    this.imageWidth = defaultImageWidth,
    this.imageHeight = defaultImageHeight,
    this.showItemDivider = defaultShowItemDivider,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type);

  KenDrawerModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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

    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']);

    drawerBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['drawerBackColor']);

    iconSize = KenUtilities.getDouble(optionsDefault!['iconSize']);

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
}
