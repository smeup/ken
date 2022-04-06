import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_timepicker_dao.dart';
import 'package:ken/smeup/models/widgets/smeup_data_interface.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';

class SmeupTimePickerModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double? defaultFontSize;
  static Color? defaultBackColor;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius;
  static double? defaultElevation;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;
  static Color? defaultCaptionBackColor;

  // unsupported by json_theme
  static const String defaultLabel = '';
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const bool defaultShowBorder = false;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = true;

  Color? backColor;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  bool? underline;
  String? label;
  double? width;
  double? height;
  String? valueField;
  String? displayedField;
  EdgeInsetsGeometry? padding;
  bool? showBorder;
  List<String>? minutesList;
  Alignment? align;
  double? innerSpace;

  SmeupTimePickerModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.backColor,
      this.fontSize,
      this.fontColor,
      this.fontBold,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.elevation,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.underline = defaultUnderline,
      this.align = defaultAlign,
      this.innerSpace = defaultInnerSpace,
      this.valueField = defaultValueField,
      this.displayedField = defaultdisplayedField,
      this.label = defaultLabel,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.showBorder = defaultShowBorder,
      title = '',
      this.minutesList})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    id = SmeupUtilities.getWidgetId('FLD', id);
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupTimePickerModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(
          jsonMap,
          formKey,
          scaffoldKey,
          context,
        ) {
    setDefaults(this);

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    displayedField = optionsDefault!['displayedField'] ?? defaultdisplayedField;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    fontSize =
        SmeupUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    label = optionsDefault!['label'] ?? defaultLabel;
    padding =
        SmeupUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    if (optionsDefault!['minutesList'] == null) {
      minutesList = null;
    } else {
      minutesList = (optionsDefault!['minutesList'] as List)
          .map((e) => e.toString())
          .toList();
    }

    elevation = SmeupUtilities.getDouble(optionsDefault!['elevation']) ??
        defaultElevation;

    showBorder = SmeupUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;
    borderRadius = SmeupUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    underline =
        SmeupUtilities.getBool(optionsDefault!['underline']) ?? defaultUnderline;

    align = SmeupUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;

    innerSpace = SmeupUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupTimePickerDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var timePickerTheme = SmeupConfigurationService.getTheme()!.timePickerTheme;
    defaultBackColor = timePickerTheme.backgroundColor;
    var shape = timePickerTheme.shape!;
    defaultBorderRadius = (shape as ContinuousRectangleBorder)
        .borderRadius
        .resolve(TextDirection.ltr)
        .topLeft
        .x;
    var side = timePickerTheme.dayPeriodBorderSide!;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var buttonStyle =
        SmeupConfigurationService.getTheme()!.elevatedButtonTheme.style!;
    defaultElevation = buttonStyle.elevation!.resolve(Set<MaterialState>());

    var textStyle = SmeupConfigurationService.getTheme()!.textTheme.bodyText1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = SmeupConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    if (obj.backColor == null)
      obj.backColor = SmeupTimePickerModel.defaultBackColor;
    if (obj.elevation == null)
      obj.elevation = SmeupTimePickerModel.defaultElevation;
    if (obj.borderColor == null)
      obj.borderColor = SmeupTimePickerModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupTimePickerModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupTimePickerModel.defaultBorderRadius;
    if (obj.fontBold == null)
      obj.fontBold = SmeupTimePickerModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupTimePickerModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupTimePickerModel.defaultFontSize;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupTimePickerModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupTimePickerModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupTimePickerModel.defaultCaptionFontSize;
  }
}
