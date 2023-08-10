// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenDashboardModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize = 60;
  static Color? defaultFontColor = KenModel.kGray100;
  static bool? defaultFontBold = false;
  static double? defaultCaptionFontSize = 20;
  static Color? defaultCaptionFontColor = KenModel.kGray100;
  static bool? defaultCaptionFontBold = false;
  static double? defaultIconSize = 40;
  static Color? defaultIconColor = KenModel.kIconColor;
  static Color? defaultBackgroundColor = Colors.transparent;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultWidth = 300;
  static const double defaultHeight = 120;
  static const String defaultValueColName = 'value';
  static const String defaultIconColName = 'icon';
  static const String defaultTextColName = 'description';
  static const String defaultUmColName = 'um';
  static const String defaultSelectLayout = '';
  static const String defaultForceText = '';
  static const String defaultForceIcon = '';
  static const String defaultForceValue = '';
  static const String defaultForceUm = '';
  static const String defaultNumberFormat = '*;0';

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? captionFontSize;
  bool? captionFontBold;
  Color? captionFontColor;
  double? iconSize;
  Color? iconColor;
  Color? backgroundColor;

  EdgeInsetsGeometry? padding;
  String? valueColName;
  String? iconColName;
  String? umColName;
  String? textColName;
  String? forceText;
  String? forceUm;
  String? forceValue;
  String? forceIcon;
  String? selectLayout;
  double? width;
  double? height;
  String? numberFormat;

  KenDashboardModel({
    id,
    type,
    formKey,
    scaffoldKey,
    context,
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.iconSize,
    this.iconColor,
    this.backgroundColor,
    this.valueColName = defaultValueColName,
    this.umColName = defaultUmColName,
    this.textColName = defaultTextColName,
    this.iconColName = defaultIconColName,
    this.padding = defaultPadding,
    this.selectLayout = defaultSelectLayout,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.forceText = defaultForceText,
    this.forceValue = defaultForceValue,
    this.forceUm = defaultForceUm,
    this.forceIcon = defaultForceIcon,
    this.numberFormat = defaultNumberFormat,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    iconColor ??= KenConfigurationService.getTheme()!.iconTheme.color;
    id = KenUtilities.getWidgetId('DSH', id);
    setDefaults(this);
  }

  KenDashboardModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);
    valueColName = optionsDefault!['ValueColName'] ?? defaultValueColName;
    iconColName = optionsDefault!['iconColName'] ?? defaultIconColName;
    textColName = optionsDefault!['textColName'] ?? defaultTextColName;
    umColName = optionsDefault!['umColName'] ?? defaultUmColName;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    if (optionsDefault!['FontSize'].toString().contains('%')) {
      double perc = KenUtilities.getDouble(
              optionsDefault!['FontSize'].toString().replaceAll("%", "")) ??
          defaultFontSize!;
      fontSize = defaultFontSize! * perc / 100;

      iconSize = KenUtilities.getDouble(optionsDefault!['iconSize']) ??
          defaultIconSize! * perc / 100;

      captionFontSize =
          KenUtilities.getDouble(optionsDefault!['labelFontSize']) ??
              defaultCaptionFontSize! * perc / 100;
    } else {
      fontSize = KenUtilities.getDouble(optionsDefault!['FontSize']) ??
          defaultFontSize;

      iconSize = KenUtilities.getDouble(optionsDefault!['iconSize']) ??
          defaultIconSize;

      captionFontSize =
          KenUtilities.getDouble(optionsDefault!['labelFontSize']) ??
              defaultCaptionFontSize;
    }

    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    backgroundColor =
        KenUtilities.getColorFromRGB(optionsDefault!['backgroundColor']) ??
            defaultBackgroundColor;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;

    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;

    selectLayout = optionsDefault!['selectLayout'] ?? '';
    forceText = optionsDefault!['forceText'] ?? '';
    forceUm = optionsDefault!['forceUm'] ?? '';
    forceIcon = optionsDefault!['forceIcon'] ?? '';
    forceValue = optionsDefault!['forceValue'] ?? '';

    numberFormat = optionsDefault!['numberFormat'] ?? defaultNumberFormat;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupDashboardDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var textStyle = KenConfigurationService.getTheme()!.textTheme.headline1!;
    // defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    // defaultFontSize = textStyle.fontSize;
    // defaultFontColor = textStyle.color;

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    // defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    // defaultCaptionFontSize = captionStyle.fontSize;
    // defaultCaptionFontColor = captionStyle.color;

    var iconTheme = KenConfigurationService.getTheme()!.iconTheme;
    // defaultIconSize = iconTheme.size;
    // defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    obj.fontBold ??= KenDashboardModel.defaultFontBold;
    obj.fontColor ??= KenDashboardModel.defaultFontColor;
    obj.fontSize ??= KenDashboardModel.defaultFontSize;
    obj.backgroundColor ??= KenDashboardModel.defaultBackgroundColor;

    obj.captionFontBold ??= KenDashboardModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenDashboardModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenDashboardModel.defaultCaptionFontSize;

    obj.iconSize ??= KenDashboardModel.defaultIconSize;
    obj.iconColor ??= KenDashboardModel.defaultIconColor;
  }
}
