// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../../services/ken_configuration_service.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

class KenButtonsModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBackColor;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius = 5;
  static double? defaultElevation = 0;
  static double? defaultFontSize = 14;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static double? defaultIconSize = 16;
  static Color? defaultIconColor = Colors.white;

  // unsupported by json_theme
  static const double defaultWidth = 180;
  static const double defaultHeight = 50;
  static const MainAxisAlignment defaultPosition = MainAxisAlignment.center;
  static const Alignment defaultAlign = Alignment.centerRight;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const String defaultValueField = 'value';
  static const double defaultInnerSpace = 10.0;
  static const bool defaultIsLink = false;
  static const WidgetOrientation defaultOrientation =
      WidgetOrientation.Vertical;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? iconSize;
  Color? iconColor;

  MainAxisAlignment? position;
  Alignment? align;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? valueField;
  dynamic iconCode;
  WidgetOrientation? orientation;
  bool? isLink;
  double? innerSpace;

  KenButtonsModel({
    id,
    type,
    title = '',
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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
    this.iconCode,
    this.orientation = defaultOrientation,
    this.isLink = defaultIsLink,
    this.innerSpace = defaultInnerSpace,
  }) : super(formKey, scaffoldKey, context, title: title, id: id) {
    // SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  KenButtonsModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    if (KenUtilities.getBool(optionsDefault!['fillSpace']) ?? false) {
      width = 0;
    }
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;

    if (KenUtilities.getBool(optionsDefault!['horiz']) ?? false) {
      orientation = WidgetOrientation.Horizontal;
    } else {
      orientation = defaultOrientation;
    }

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    position = KenUtilities.getMainAxisAlignment(optionsDefault!['position']);
    iconSize =
        KenUtilities.getDouble(optionsDefault!['iconSize']) ?? defaultIconSize;
    if (optionsDefault!['icon'] != null) iconCode = optionsDefault!['icon'];
    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;
    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    elevation = KenUtilities.getDouble(optionsDefault!['elevation']) ??
        defaultElevation;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    isLink = KenUtilities.getBool(optionsDefault!['flat']) ?? defaultIsLink;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await getData();
        // await SmeupButtonsDao.getData(this);
      };
    }
    // SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var buttonStyle =
        KenConfigurationService.getTheme()!.elevatedButtonTheme.style!;

    defaultBackColor = buttonStyle.backgroundColor!.resolve(<MaterialState>{});
    defaultElevation = buttonStyle.elevation!.resolve(<MaterialState>{});

    var side = buttonStyle.side!.resolve(<MaterialState>{})!;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var shape = buttonStyle.shape!.resolve(<MaterialState>{})!;
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;

    var textStyle = KenConfigurationService.getTheme()!.textTheme.button!;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;

    var iconTheme = KenConfigurationService.getTheme()!.iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    obj.backColor ??= KenButtonsModel.defaultBackColor;
    obj.borderColor ??= KenButtonsModel.defaultBorderColor;
    obj.borderWidth ??= KenButtonsModel.defaultBorderWidth;
    obj.borderRadius ??= KenButtonsModel.defaultBorderRadius;
    obj.elevation ??= KenButtonsModel.defaultElevation;
    obj.fontSize ??= KenButtonsModel.defaultFontSize;
    obj.fontColor ??= KenButtonsModel.defaultFontColor;
    obj.fontBold ??= KenButtonsModel.defaultFontBold;
    obj.iconSize ??= KenButtonsModel.defaultIconSize;
    obj.iconColor ??= KenButtonsModel.defaultIconColor;
  }
}
