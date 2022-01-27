import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_dashboard_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupDashboardModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double defaultFontSize;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static bool defaultCaptionFontBold;
  static double defaultIconSize;
  static Color defaultIconColor;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const double defaultWidth = 120;
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

  double fontSize;
  Color fontColor;
  bool fontBold;
  double captionFontSize;
  bool captionFontBold;
  Color captionFontColor;
  double iconSize;
  Color iconColor;

  EdgeInsetsGeometry padding;
  String valueColName;
  String iconColName;
  String umColName;
  String textColName;
  String forceText;
  String forceUm;
  String forceValue;
  String forceIcon;
  String selectLayout;
  double width;
  double height;
  String numberFormat;

  SmeupDashboardModel(
      {id,
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
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (iconColor == null)
      iconColor = SmeupConfigurationService.getTheme().iconTheme.color;
    id = SmeupUtilities.getWidgetId('DSH', id);
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupDashboardModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    setDefaults(this);
    valueColName = optionsDefault['ValueColName'] ?? defaultValueColName;
    iconColName = optionsDefault['iconColName'] ?? defaultIconColName;
    textColName = optionsDefault['textColName'] ?? defaultTextColName;
    umColName = optionsDefault['umColName'] ?? defaultUmColName;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    if (optionsDefault['FontSize'].toString().contains('%')) {
      double perc = SmeupUtilities.getDouble(
              optionsDefault['FontSize'].toString().replaceAll("%", "")) ??
          defaultFontSize;
      fontSize = defaultFontSize * perc / 100;

      iconSize = SmeupUtilities.getDouble(optionsDefault['iconSize']) ??
          defaultIconSize * perc / 100;

      captionFontSize =
          SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
              defaultCaptionFontSize * perc / 100;
    } else {
      fontSize = SmeupUtilities.getDouble(optionsDefault['FontSize']) ??
          defaultFontSize;

      iconSize = SmeupUtilities.getDouble(optionsDefault['iconSize']) ??
          defaultIconSize;

      captionFontSize =
          SmeupUtilities.getDouble(optionsDefault['labelFontSize']) ??
              defaultCaptionFontSize;
    }

    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;

    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;

    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

    iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
        defaultIconColor;

    selectLayout = optionsDefault['selectLayout'] ?? '';
    forceText = optionsDefault['forceText'] ?? '';
    forceUm = optionsDefault['forceUm'] ?? '';
    forceIcon = optionsDefault['forceIcon'] ?? '';
    forceValue = optionsDefault['forceValue'] ?? '';

    numberFormat = optionsDefault['numberFormat'] ?? defaultNumberFormat;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupDashboardDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var textStyle = SmeupConfigurationService.getTheme().textTheme.headline1;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.fontBold == null)
      obj.fontBold = SmeupDashboardModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupDashboardModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupDashboardModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupDashboardModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupDashboardModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupDashboardModel.defaultCaptionFontSize;

    if (obj.iconSize == null)
      obj.iconSize = SmeupDashboardModel.defaultIconSize;
    if (obj.iconColor == null)
      obj.iconColor = SmeupDashboardModel.defaultIconColor;
  }
}
