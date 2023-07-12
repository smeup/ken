import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenDashboardModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static double? defaultFontSize = 60;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static double? defaultCaptionFontSize = 20;
  static Color? defaultCaptionFontColor;
  static bool? defaultCaptionFontBold;
  static double? defaultIconSize = 40;
  static Color? defaultIconColor;

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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (iconColor == null)
      iconColor = KenConfigurationService.getTheme()!.iconTheme.color;
    id = KenUtilities.getWidgetId('DSH', id);
    setDefaults(this);
  }

  KenDashboardModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          instanceCallBack)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
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
        await this.getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var textStyle = KenConfigurationService.getTheme()!.textTheme.headline1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    var iconTheme = KenConfigurationService.getTheme()!.iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.fontBold == null) obj.fontBold = KenDashboardModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = KenDashboardModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = KenDashboardModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = KenDashboardModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenDashboardModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenDashboardModel.defaultCaptionFontSize;

    if (obj.iconSize == null) obj.iconSize = KenDashboardModel.defaultIconSize;
    if (obj.iconColor == null)
      obj.iconColor = KenDashboardModel.defaultIconColor;
  }
}
