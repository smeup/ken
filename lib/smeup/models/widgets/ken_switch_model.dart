// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenSwitchModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultThumbColor = KenModel.kButtonBackgroundColor;
  static Color? defaultTrackColor = KenModel.kGray100;
  static double? defaultCaptionFontSize = 14;
  static Color? defaultCaptionFontColor = KenModel.kGray100;
  static Color? defaultCaptionBackColor = Colors.transparent;
  static bool? defaultCaptionFontBold = false;

  // unsupported by json_theme
  static const double defaultWidth = 400;
  static const double defaultHeight = 50;
  static const Alignment defaultAlign = Alignment.center;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? captionFontBold;
  Color? thumbColor;
  Color? trackColor;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? text;

  KenSwitchModel({
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    id,
    type,
    title = '',
    this.text = '',
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.captionFontBold,
    this.thumbColor,
    this.trackColor,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.padding = defaultPadding,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'swt';
    setDefaults(this);
  }

  KenSwitchModel.fromMap(
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
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    captionFontSize = KenUtilities.getDouble(optionsDefault!['fontSize']) ??
        defaultCaptionFontSize;

    captionBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
            defaultCaptionBackColor;

    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
            defaultCaptionFontColor;

    captionFontBold = optionsDefault!['bold'] ?? defaultCaptionFontBold;

    thumbColor = KenUtilities.getColorFromRGB(optionsDefault!['thumbColor']) ??
        defaultThumbColor;

    trackColor = KenUtilities.getColorFromRGB(optionsDefault!['trackColor']) ??
        defaultTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupSwitchDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var radioTheme = KenConfigurationService.getTheme()!.switchTheme;

    defaultThumbColor = radioTheme.thumbColor!.resolve(<MaterialState>{});
    defaultTrackColor = radioTheme.trackColor!.resolve(<MaterialState>{});

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    obj.thumbColor ??= KenSwitchModel.defaultThumbColor;
    obj.trackColor ??= KenSwitchModel.defaultTrackColor;

    obj.captionFontColor ??= KenSwitchModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenSwitchModel.defaultCaptionFontSize;
    obj.captionBackColor ??= KenSwitchModel.defaultCaptionBackColor;
    obj.captionFontBold ??= KenSwitchModel.defaultCaptionFontBold;
  }
}
