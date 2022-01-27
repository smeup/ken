import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_buttons_dao.dart';

import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupButtonsModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultBackColor;
  static Color defaultBorderColor;
  static double defaultBorderWidth;
  static double defaultBorderRadius;
  static double defaultElevation;
  static double defaultFontSize;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static double defaultIconSize;
  static Color defaultIconColor;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 70;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.center;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const String defaultValueField = 'value';
  static const double defaultInnerSpace = 10.0;
  static const bool defaultIsLink = false;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.Vertical;

  Color backColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double elevation;
  double fontSize;
  Color fontColor;
  bool fontBold;
  double iconSize;
  Color iconColor;

  MainAxisAlignment position;
  Alignment align;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  String valueField;
  int iconData;
  WidgetOrientation orientation;
  bool isLink;
  double innerSpace;

  SmeupButtonsModel(
      {id,
      type,
      title = '',
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      this.backColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.elevation,
      this.fontSize,
      this.fontColor,
      this.fontBold,
      this.iconSize,
      this.iconColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.position = defaultPosition,
      this.align = defaultAlign,
      this.padding = defaultPadding,
      this.valueField,
      this.iconData = 0,
      this.orientation = defaultOrientation,
      this.isLink = defaultIsLink,
      this.innerSpace = defaultInnerSpace})
      : super(formKey, scaffoldKey, context, title: title) {
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupButtonsModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    if (SmeupUtilities.getBool(optionsDefault['fillSpace']) ?? false) {
      width = 0;
    }
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
        defaultInnerSpace;

    if (SmeupUtilities.getBool(optionsDefault['horiz']) ?? false) {
      orientation = WidgetOrientation.Horizontal;
    } else {
      orientation = defaultOrientation;
    }

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    position = SmeupUtilities.getMainAxisAlignment(optionsDefault['position']);
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    if (optionsDefault['icon'] != null)
      iconData = SmeupUtilities.getInt(optionsDefault['icon']) ?? 0;
    else
      iconData = 0;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;
    iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
        defaultIconColor;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
        defaultBorderWidth;
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;

    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
            defaultBorderColor;

    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;

    isLink = SmeupUtilities.getBool(optionsDefault['flat']) ?? defaultIsLink;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupButtonsDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var buttonStyle =
        SmeupConfigurationService.getTheme().elevatedButtonTheme.style;

    defaultBackColor =
        buttonStyle.backgroundColor.resolve(Set<MaterialState>());
    defaultElevation = buttonStyle.elevation.resolve(Set<MaterialState>());

    var side = buttonStyle.side.resolve(Set<MaterialState>());
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var shape = buttonStyle.shape.resolve(Set<MaterialState>());
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;

    var textStyle = SmeupConfigurationService.getTheme().textTheme.button;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;

    var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.backColor == null)
      obj.backColor = SmeupButtonsModel.defaultBackColor;
    if (obj.borderColor == null)
      obj.borderColor = SmeupButtonsModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupButtonsModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupButtonsModel.defaultBorderRadius;
    if (obj.elevation == null)
      obj.elevation = SmeupButtonsModel.defaultElevation;
    if (obj.fontSize == null) obj.fontSize = SmeupButtonsModel.defaultFontSize;
    if (obj.fontColor == null)
      obj.fontColor = SmeupButtonsModel.defaultFontColor;
    if (obj.fontBold == null) obj.fontBold = SmeupButtonsModel.defaultFontBold;
    if (obj.iconSize == null) obj.iconSize = SmeupButtonsModel.defaultIconSize;
    if (obj.iconColor == null)
      obj.iconColor = SmeupButtonsModel.defaultIconColor;
  }
}
