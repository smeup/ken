import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_text_autocomplete_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTextAutocompleteModel extends SmeupModel
    implements SmeupDataInterface {
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
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const bool defaultAutoFocus = false;
  static const bool defaultUnderline = true;
  static const String defaultSubmitLabel = '';
  static const bool defaultShowSubmit = false;

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
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;
  bool showUnderline;
  bool autoFocus;
  String defaultValue;
  String valueField;
  String submitLabel;
  bool showSubmit;

  SmeupTextAutocompleteModel(
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
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showBorder = defaultShowBorder,
      title = '',
      this.showUnderline = defaultUnderline,
      this.autoFocus = defaultAutoFocus,
      this.defaultValue = '',
      this.valueField = 'value'})
      : super(formKey, title: title, id: id, type: type) {
    if (optionsDefault['type'] == null) optionsDefault['type'] = 'acp';
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupTextAutocompleteModel.fromMap(
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
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    showUnderline = optionsDefault['showUnderline'] ?? true;
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

    defaultValue = jsonMap['defaultValue'] ?? '';
    valueField = optionsDefault['valueField'] ?? 'value';
    showSubmit = optionsDefault['showSubmit'] ?? defaultShowSubmit;
    submitLabel = optionsDefault['submitLabel'] ?? defaultSubmitLabel;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupTextAutocompleteDao.getData(this);
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
      obj.borderColor = SmeupTextAutocompleteModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupTextAutocompleteModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupTextAutocompleteModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = SmeupTextAutocompleteModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupTextAutocompleteModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupTextAutocompleteModel.defaultFontSize;
    if (obj.backColor == null)
      obj.backColor = SmeupTextAutocompleteModel.defaultBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupTextAutocompleteModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupTextAutocompleteModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupTextAutocompleteModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupTextAutocompleteModel.defaultCaptionBackColor;
  }
}
