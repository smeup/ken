import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_datepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupDatePickerModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultBorderColor;
  static double defaultBorderWidth;
  static double defaultBorderRadius;
  static bool defaultFontBold;
  static double defaultFontSize;
  static Color defaultFontColor;
  static Color defaultBackColor;
  static double defaultElevation;

  // unsupported by json_theme
  static const bool defaultUnderline = true;
  static const String defaultLabel = '';
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const bool defaultShowBorder = false;
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;

  Color borderColor;
  double borderWidth;
  double borderRadius;
  bool fontBold;
  bool underline;
  double fontSize;
  Color fontColor;
  Color backColor;
  double elevation;
  double innerSpace;
  Alignment align;
  String valueField;
  String displayedField;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showBorder;

  List<String> minutesList;

  SmeupDatePickerModel(
      {GlobalKey<FormState> formKey,
      id,
      type,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.fontBold,
      this.underline,
      this.fontSize,
      this.fontColor,
      this.backColor,
      this.elevation,
      this.align = defaultAlign,
      this.valueField = defaultValueField,
      this.displayedField = defaultdisplayedField,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showBorder = defaultShowBorder,
      this.innerSpace = defaultInnerSpace,
      title = '',
      this.minutesList})
      : super(formKey, id: id, type: type, title: title) {
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
    SmeupDatePickerModel.setDefaults(this);
  }

  SmeupDatePickerModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    SmeupDatePickerModel.setDefaults(this);

    valueField = optionsDefault['valueField'] ?? defaultValueField;
    displayedField = optionsDefault['displayedField'] ?? defaultdisplayedField;
    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;
    fontSize =
        SmeupUtilities.getDouble(optionsDefault['fontSize']) ?? defaultFontSize;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    label = optionsDefault['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    elevation = SmeupUtilities.getDouble(optionsDefault['elevation']) ??
        defaultElevation;
    if (optionsDefault['minutesList'] == null) {
      minutesList = null;
    } else {
      minutesList = (optionsDefault['minutesList'] as List)
          .map((e) => e.toString())
          .toList();
    }
    innerSpace = SmeupUtilities.getDouble(optionsDefault['innerSpace']) ??
        defaultInnerSpace;
    showBorder = SmeupUtilities.getBool(optionsDefault['showborder']) ??
        defaultShowBorder;

    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
            defaultBorderColor;

    fontBold = optionsDefault['bold'] ?? defaultFontBold;
    underline =
        SmeupUtilities.getBool(optionsDefault['underline']) ?? defaultUnderline;

    align = SmeupUtilities.getAlignmentGeometry(optionsDefault['align']) ??
        defaultAlign;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupDatePickerDao.getData(this);
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

    var buttonStyle =
        SmeupConfigurationService.getTheme().elevatedButtonTheme.style;
    defaultElevation = buttonStyle.elevation.resolve(Set<MaterialState>());

    var textStyle = SmeupConfigurationService.getTheme().textTheme.bodyText1;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    // ----------------- set properties from default
    if (obj.backColor == null)
      obj.backColor = SmeupDatePickerModel.defaultBackColor;
    if (obj.elevation == null)
      obj.elevation = SmeupDatePickerModel.defaultElevation;
    if (obj.borderColor == null)
      obj.borderColor = SmeupDatePickerModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupDatePickerModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupDatePickerModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = SmeupDatePickerModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupDatePickerModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupDatePickerModel.defaultFontSize;
  }
}
