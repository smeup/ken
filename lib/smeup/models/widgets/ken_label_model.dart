import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../../services/ken_configuration_service.dart';

class KenLabelModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize = 20;
  static Color? defaultFontColor;
  static bool? defaultFontBold = false;
  static Color? defaultBackColor = Colors.transparent;
  static double? defaultIconSize = 20;
  static Color? defaultIconColor;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const Alignment defaultAlign = Alignment.centerRight;
  static const double defaultWidth = 0;
  static const double defaultHeight = 15;
  static const String defaultValColName = 'value';

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  Color? backColor;
  double? iconSize;
  Color? iconColor;

  EdgeInsetsGeometry? padding;
  Alignment? align;
  double? width;
  double? height;
  String? valueColName;
  String? backColorColName;
  String? fontColorColName;
  dynamic iconCode;
  String? iconColname;

  KenLabelModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.backColor,
    this.iconSize,
    this.iconColor,
    this.valueColName = defaultValColName,
    this.padding = defaultPadding,
    this.align = defaultAlign,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.backColorColName = '',
    this.iconCode,
    this.iconColname = '',
    this.fontColorColName = '',
    title = '',
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type) {
    setDefaults(this);
  }

  KenLabelModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    if (fontColor == null)
      fontColor =
          KenConfigurationService.getTheme()!.textTheme.bodyText1!.color;

    valueColName = optionsDefault!['valueColName'] ?? defaultValColName;
    backColorColName = optionsDefault!['backColorColName'] ?? '';
    fontColorColName = optionsDefault!['fontColorColName'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;
    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    title = jsonMap['title'] ?? '';
    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;
    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;
    if (optionsDefault!['icon'] != null) iconCode = optionsDefault!['icon'];
    iconColname = optionsDefault!['iconColName'] ?? '';
    fontBold =
        KenUtilities.getBool(optionsDefault!['fontBold']) ?? defaultFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupLabelDao.getData(this);
        await this.getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    TextStyle textStyle =
        KenConfigurationService.getTheme()!.textTheme.bodyText2!;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = textStyle.backgroundColor;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;

    var iconTheme = KenConfigurationService.getTheme()!.iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.fontSize == null) obj.fontSize = KenLabelModel.defaultFontSize;
    if (obj.fontColor == null) obj.fontColor = KenLabelModel.defaultFontColor;
    if (obj.backColor == null) obj.backColor = KenLabelModel.defaultBackColor;
    if (obj.fontBold == null) obj.fontBold = KenLabelModel.defaultFontBold;
    if (obj.iconSize == null) obj.iconSize = KenLabelModel.defaultIconSize;
    if (obj.iconColor == null) obj.iconColor = KenLabelModel.defaultIconColor;
  }
}
