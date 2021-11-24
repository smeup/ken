import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_switch_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupSwitchModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultThumbColor;
  static Color defaultTrackColor;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static Color defaultCaptionBackColor;
  static bool defaultCaptionFontBold;

  // unsupported by json_theme
  static const double defaultWidth = 100;
  static const double defaultHeight = 50;
  static const Alignment defaultAlign = Alignment.center;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);

  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  bool captionFontBold;
  Color thumbColor;
  Color trackColor;

  double width;
  double height;
  EdgeInsetsGeometry padding;
  String text;

  SmeupSwitchModel({
    GlobalKey<FormState> formKey,
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
  }) : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'swt';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupSwitchModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);
    title = jsonMap['title'] ?? '';
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    captionFontSize = SmeupUtilities.getDouble(optionsDefault['fontSize']) ??
        defaultCaptionFontSize;

    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
            defaultCaptionBackColor;

    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
            defaultCaptionFontColor;

    captionFontBold = optionsDefault['bold'] ?? defaultCaptionFontBold;

    thumbColor = SmeupUtilities.getColorFromRGB(optionsDefault['thumbColor']) ??
        defaultThumbColor;

    trackColor = SmeupUtilities.getColorFromRGB(optionsDefault['trackColor']) ??
        defaultTrackColor;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupSwitchDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var radioTheme = SmeupConfigurationService.getTheme().switchTheme;

    defaultThumbColor = radioTheme.thumbColor.resolve(Set<MaterialState>());
    defaultTrackColor = radioTheme.trackColor.resolve(Set<MaterialState>());

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    if (obj.thumbColor == null)
      obj.thumbColor = SmeupSwitchModel.defaultThumbColor;
    if (obj.trackColor == null)
      obj.trackColor = SmeupSwitchModel.defaultTrackColor;

    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupSwitchModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupSwitchModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupSwitchModel.defaultCaptionBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupSwitchModel.defaultCaptionFontBold;
  }
}
