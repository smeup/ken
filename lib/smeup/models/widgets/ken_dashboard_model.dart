// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenDashboardModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const double defaultFontSize = 60;
  static const Color defaultFontColor = KenModel.kSecondary100;
  static const bool defaultFontBold = false;
  static const double defaultCaptionFontSize = 20;
  static const Color defaultCaptionFontColor = KenModel.kSecondary100;
  static const bool defaultCaptionFontBold = false;
  static const double defaultIconSize = 40;
  static const Color defaultIconColor = KenModel.kIconColor;
  static const Color defaultBackgroundColor = Colors.transparent;
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
    this.fontColor = defaultFontColor,
    this.fontSize = defaultFontSize,
    this.fontBold = defaultFontBold,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultCaptionFontColor,
    this.iconSize = defaultIconSize,
    this.iconColor = defaultIconColor,
    this.backgroundColor = defaultBackgroundColor,
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
  }

  KenDashboardModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupDashboardDao.getData(this);
        await getData();
      };
    }
  }
}
