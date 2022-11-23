import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';

import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_theme_configuration_service.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

class KenButtonsModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBackColor;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius;
  static double? defaultElevation;
  static double? defaultFontSize;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static double? defaultIconSize;
  static Color? defaultIconColor;

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

  KenButtonsModel(
      {id,
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
        required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack,
      })
      : super(formKey, scaffoldKey, context, title: title,instanceCallBack: instanceCallBack) {
    // SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  KenButtonsModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context, Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap, KenModel? instance) instanceCallBack)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack, null) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    if (KenUtilities.getBool(optionsDefault!['fillSpace']) ?? false) {
      width = 0;
    }
    height =
        KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;

    if (KenUtilities.getBool(optionsDefault!['horiz']) ?? false) {
      orientation = WidgetOrientation.Horizontal;
    } else {
      orientation = defaultOrientation;
    }

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    position = KenUtilities.getMainAxisAlignment(optionsDefault!['position']);
    iconSize = KenUtilities.getDouble(optionsDefault!['iconSize']) ??
        defaultIconSize;
    if (optionsDefault!['icon'] != null) iconCode = optionsDefault!['icon'];
    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;
    iconColor = KenUtilities.getColorFromRGB(optionsDefault!['iconColor']) ??
        defaultIconColor;
    fontSize = KenUtilities.getDouble(optionsDefault!['fontSize']) ??
        defaultFontSize;
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

        await this.getData(instanceCallBack);
        // await SmeupButtonsDao.getData(this);
      };
    }
    // SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var buttonStyle =
    KenThemeConfigurationService.getTheme()!.elevatedButtonTheme.style!;

    defaultBackColor =
        buttonStyle.backgroundColor!.resolve(Set<MaterialState>());
    defaultElevation = buttonStyle.elevation!.resolve(Set<MaterialState>());

    var side = buttonStyle.side!.resolve(Set<MaterialState>())!;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var shape = buttonStyle.shape!.resolve(Set<MaterialState>())!;
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;

    var textStyle = KenThemeConfigurationService.getTheme()!.textTheme.button!;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;

    var iconTheme = KenThemeConfigurationService.getTheme()!.iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = iconTheme.color;

    // ----------------- set properties from default

    if (obj.backColor == null)
      obj.backColor = KenButtonsModel.defaultBackColor;
    if (obj.borderColor == null)
      obj.borderColor = KenButtonsModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenButtonsModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenButtonsModel.defaultBorderRadius;
    if (obj.elevation == null)
      obj.elevation = KenButtonsModel.defaultElevation;
    if (obj.fontSize == null) obj.fontSize = KenButtonsModel.defaultFontSize;
    if (obj.fontColor == null)
      obj.fontColor = KenButtonsModel.defaultFontColor;
    if (obj.fontBold == null) obj.fontBold = KenButtonsModel.defaultFontBold;
    if (obj.iconSize == null) obj.iconSize = KenButtonsModel.defaultIconSize;
    if (obj.iconColor == null)
      obj.iconColor = KenButtonsModel.defaultIconColor;
  }
}

