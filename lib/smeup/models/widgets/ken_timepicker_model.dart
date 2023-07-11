import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../../services/ken_configuration_service.dart';

class KenTimePickerModel extends KenModel implements KenDataInterface {
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
  static List<String> defaultMinutesList = [
    '00',
    '01',
    '02',
    '03',
    '04',
    '05',
    '06',
    '07',
    '08',
    '09',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '18',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36',
    '37',
    '38',
    '39',
    '40',
    '41',
    '42',
    '43',
    '44',
    '45',
    '46',
    '47',
    '48',
    '49',
    '50',
    '51',
    '52',
    '53',
    '54',
    '55',
    '56',
    '57',
    '58',
    '59'
  ];

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

  KenTimePickerModel({
    id,
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
    this.minutesList,
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    id = KenUtilities.getWidgetId('FLD', id);
    setDefaults(this);
  }

  KenTimePickerModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    setDefaults(this);

    valueField = optionsDefault!['valueField'] ?? defaultValueField;
    displayedField = optionsDefault!['displayedField'] ?? defaultdisplayedField;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;

    fontSize =
        KenUtilities.getDouble(optionsDefault!['fontSize']) ?? defaultFontSize;

    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    label = optionsDefault!['label'] ?? defaultLabel;
    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    if (optionsDefault!['minutesList'] == null) {
      minutesList = defaultMinutesList;
    } else {
      minutesList = (optionsDefault!['minutesList'] as List)
          .map((e) => e.toString())
          .toList();
    }

    elevation = KenUtilities.getDouble(optionsDefault!['elevation']) ??
        defaultElevation;

    showBorder = KenUtilities.getBool(optionsDefault!['showborder']) ??
        defaultShowBorder;
    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    captionBackColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionBackColor']) ??
            defaultCaptionBackColor;
    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    underline =
        KenUtilities.getBool(optionsDefault!['underline']) ?? defaultUnderline;

    align = KenUtilities.getAlignmentGeometry(optionsDefault!['align']) ??
        defaultAlign;

    innerSpace = KenUtilities.getDouble(optionsDefault!['innerSpace']) ??
        defaultInnerSpace;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupTimePickerDao.getData(this);
        await this.getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var timePickerTheme = KenConfigurationService.getTheme()!.timePickerTheme;
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
        KenConfigurationService.getTheme()!.elevatedButtonTheme.style!;
    defaultElevation = buttonStyle.elevation!.resolve(Set<MaterialState>());

    var textStyle = KenConfigurationService.getTheme()!.textTheme.bodyText1!;
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.caption!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    if (obj.backColor == null)
      obj.backColor = KenTimePickerModel.defaultBackColor;
    if (obj.elevation == null)
      obj.elevation = KenTimePickerModel.defaultElevation;
    if (obj.borderColor == null)
      obj.borderColor = KenTimePickerModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenTimePickerModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenTimePickerModel.defaultBorderRadius;
    if (obj.fontBold == null) obj.fontBold = KenTimePickerModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = KenTimePickerModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = KenTimePickerModel.defaultFontSize;
    if (obj.captionFontBold == null)
      obj.captionFontBold = KenTimePickerModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenTimePickerModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenTimePickerModel.defaultCaptionFontSize;
  }
}
