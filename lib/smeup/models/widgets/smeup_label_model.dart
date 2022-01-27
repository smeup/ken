import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_label_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupLabelModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double defaultFontSize;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static Color defaultBackColor;
  static double defaultIconSize;
  static Color defaultIconColor;

  // unsupported by json_theme
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const Alignment defaultAlign = Alignment.center;
  static const double defaultWidth = 0;
  static const double defaultHeight = 15;
  static const String defaultValColName = 'value';

  double fontSize;
  Color fontColor;
  bool fontBold;
  Color backColor;
  double iconSize;
  Color iconColor;

  EdgeInsetsGeometry padding;
  Alignment align;
  double width;
  double height;
  String valueColName;
  String backColorColName;
  String fontColorColName;
  int iconData;
  String iconColname;

  SmeupLabelModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
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
      this.iconData = 0,
      this.iconColname = '',
      this.fontColorColName = '',
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupLabelModel.fromMap(
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

    if (fontColor == null)
      fontColor =
          SmeupConfigurationService.getTheme().textTheme.bodyText1.color;

    valueColName = optionsDefault['valueColName'] ?? defaultValColName;
    backColorColName = optionsDefault['backColorColName'] ?? '';
    fontColorColName = optionsDefault['fontColorColName'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
        defaultIconColor;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    title = jsonMap['title'] ?? '';
    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    if (optionsDefault['icon'] != null)
      iconData = SmeupUtilities.getInt(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    iconColname = optionsDefault['iconColName'] ?? '';
    fontBold =
        SmeupUtilities.getBool(optionsDefault['fontBold']) ?? defaultFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupLabelDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    TextStyle textStyle =
        SmeupConfigurationService.getTheme().textTheme.bodyText2;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = textStyle.backgroundColor;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;

    var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.fontSize == null) obj.fontSize = SmeupLabelModel.defaultFontSize;
    if (obj.fontColor == null) obj.fontColor = SmeupLabelModel.defaultFontColor;
    if (obj.backColor == null) obj.backColor = SmeupLabelModel.defaultBackColor;
    if (obj.fontBold == null) obj.fontBold = SmeupLabelModel.defaultFontBold;
    if (obj.iconSize == null) obj.iconSize = SmeupLabelModel.defaultIconSize;
    if (obj.iconColor == null) obj.iconColor = SmeupLabelModel.defaultIconColor;
  }
}
