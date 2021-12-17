import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_password_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTextPasswordModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double defaultFontSize;
  static Color defaultBackColor;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static bool defaultCaptionFontBold;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static Color defaultCaptionBackColor;
  static Color defaultBorderColor;
  static double defaultBorderWidth;
  static double defaultBorderRadius;

  // unsupported by json_theme

  static const String defaultLabel = '';
  static const String defaultSubmitLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const String defaultValueField = 'value';
  static const bool defaultShowSubmit = false;
  static const bool defaultUnderline = true;
  static const bool defaultShowRules = true;
  static const bool defaultShowRulesIcon = true;
  static const bool defaultCheckRules = true;

  Color backColor;
  double fontSize;
  Color fontColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;

  String label;
  String submitLabel;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;
  bool underline;
  bool autoFocus;
  String valueField;
  bool showSubmit;
  bool showRules;
  bool showRulesIcon;
  bool checkRules;

  SmeupTextPasswordModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.backColor,
      this.fontSize,
      this.fontBold,
      this.fontColor,
      this.captionBackColor,
      this.captionFontBold,
      this.captionFontColor,
      this.captionFontSize,
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.label = defaultLabel,
      this.submitLabel = defaultSubmitLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showBorder = defaultShowBorder,
      this.showSubmit = defaultShowSubmit,
      this.showRulesIcon = defaultShowRulesIcon,
      title = '',
      this.underline = defaultUnderline,
      this.autoFocus = defaultAutoFocus,
      this.valueField,
      this.showRules = defaultShowRules,
      this.checkRules = defaultCheckRules})
      : super(formKey, title: title, id: id, type: type) {
    if (backColor == null)
      backColor = SmeupConfigurationService.getTheme().backgroundColor;
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'pwd';
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupTextPasswordModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);
    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

    label = optionsDefault['label'] ?? defaultLabel;
    submitLabel = optionsDefault['submitLabel'] ?? defaultSubmitLabel;
    valueField = optionsDefault['valueField'] ?? defaultValueField;
    showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    underline = optionsDefault['showUnderline'] ?? true;
    autoFocus = optionsDefault['autoFocus'] ?? false;

    showBorder = SmeupUtilities.getBool(optionsDefault['showborder']) ??
        defaultShowBorder;
    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
            defaultBorderColor;

    showRules =
        SmeupUtilities.getBool(optionsDefault['showRules']) ?? defaultShowRules;

    showRulesIcon = SmeupUtilities.getBool(optionsDefault['showRulesIcon']) ??
        defaultShowRulesIcon;

    checkRules = SmeupUtilities.getBool(optionsDefault['checkRules']) ??
        defaultCheckRules;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupTextPasswordDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var timePickerTheme = SmeupConfigurationService.getTheme().timePickerTheme;
    defaultBackColor = timePickerTheme.backgroundColor;
    var shape = timePickerTheme.shape;
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;
    var side = timePickerTheme.dayPeriodBorderSide;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

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

    // ----------------- set properties from default
    if (obj.borderColor == null)
      obj.borderColor = SmeupTextPasswordModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupTextPasswordModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupTextPasswordModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = SmeupTextPasswordModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupTextPasswordModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupTextPasswordModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = SmeupTextPasswordModel.defaultBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupTextPasswordModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupTextPasswordModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupTextPasswordModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupTextPasswordModel.defaultCaptionBackColor;
  }
}
