import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_combo_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupComboModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double defaultIconSize;
  static Color defaultIconColor;
  static double defaultFontSize;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static Color defaultBackColor;
  static bool defaultCaptionFontBold;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static Color defaultCaptionBackColor;

  // unsupported by json_theme
  static const double defaultWidth = 100;
  static const double defaultHeight = 20;
  static const String defaultValueField = 'value';
  static const String defaultDescriptionField = 'description';
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const String defaultLabel = '';
  static const Alignment defaultAlign = Alignment.centerLeft;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;

  double fontSize;
  Color fontColor;
  bool fontBold;
  Color backColor;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  double iconSize;
  Color iconColor;

  bool underline;
  double width;
  double height;
  double innerSpace;
  Alignment align;
  String valueField;
  String descriptionField;
  String selectedValue;
  String label;
  EdgeInsetsGeometry padding;

  SmeupComboModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context,
      this.fontColor,
      this.fontSize,
      this.fontBold,
      this.backColor,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.iconSize,
      this.iconColor,
      this.underline = defaultUnderline,
      this.align = defaultAlign,
      this.innerSpace = defaultInnerSpace,
      this.valueField = defaultValueField,
      this.descriptionField = defaultDescriptionField,
      this.padding = defaultPadding,
      this.selectedValue = '',
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'cmb';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupComboModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState> formKey,
      GlobalKey<ScaffoldState> scaffoldKey,
      BuildContext context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    descriptionField =
        optionsDefault['descriptionField'] ?? defaultDescriptionField;
    selectedValue = optionsDefault['defaultValue'] ?? '';
    label = optionsDefault['label'] ?? defaultLabel;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    iconSize =
        SmeupUtilities.getDouble(optionsDefault['iconSize']) ?? defaultIconSize;
    iconColor = SmeupUtilities.getColorFromRGB(optionsDefault['iconColor']) ??
        defaultIconColor;

    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault['bold'] ?? defaultFontBold;
    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    underline =
        SmeupUtilities.getBool(optionsDefault['underline']) ?? defaultUnderline;

    innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
        defaultInnerSpace;
    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;
    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;
    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionBackColor']) ??
            defaultCaptionBackColor;

    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupComboDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var textStyle = SmeupConfigurationService.getTheme().textTheme.bodyText1;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;
    defaultBackColor = textStyle.backgroundColor;

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    var iconTheme = SmeupConfigurationService.getTheme().iconTheme;
    defaultIconSize = iconTheme.size;
    defaultIconColor = textStyle.color;
    //iconTheme.color;

    // ----------------- set properties from default
    if (obj.fontBold == null) obj.fontBold = SmeupComboModel.defaultFontBold;
    if (obj.fontColor == null) obj.fontColor = SmeupComboModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = SmeupComboModel.defaultFontSize;
    if (obj.backColor == null) obj.backColor = SmeupComboModel.defaultBackColor;

    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupComboModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupComboModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupComboModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupComboModel.defaultCaptionBackColor;

    if (obj.iconSize == null) obj.iconSize = SmeupComboModel.defaultIconSize;
    if (obj.iconColor == null) obj.iconColor = SmeupComboModel.defaultIconColor;
  }
}
