import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import '../../services/ken_configuration_service.dart';

class KenSwitchModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultThumbColor;
  static Color? defaultTrackColor;
  static double? defaultCaptionFontSize = 14;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor = Colors.transparent;
  static bool? defaultCaptionFontBold;

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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'swt';
    setDefaults(this);
  }

  KenSwitchModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
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
        await this.getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var radioTheme = KenConfigurationService.getTheme()!.switchTheme;

    defaultThumbColor = radioTheme.thumbColor!.resolve(Set<MaterialState>());
    defaultTrackColor = radioTheme.trackColor!.resolve(Set<MaterialState>());

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    if (obj.thumbColor == null)
      obj.thumbColor = KenSwitchModel.defaultThumbColor;
    if (obj.trackColor == null)
      obj.trackColor = KenSwitchModel.defaultTrackColor;

    if (obj.captionFontColor == null)
      obj.captionFontColor = KenSwitchModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenSwitchModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = KenSwitchModel.defaultCaptionBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = KenSwitchModel.defaultCaptionFontBold;
  }
}
