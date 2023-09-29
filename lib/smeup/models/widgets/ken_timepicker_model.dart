// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenTimePickerModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const double defaultFontSize = 16;
  static const Color defaultBackColor = Colors.transparent;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const bool defaultFontBold = false;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 1.0;
  static const double defaultBorderRadius = 4;
  static const double defaultElevation = 0.0;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
  static const Color defaultCaptionBackColor = Colors.transparent;
  static const List<String> defaultMinutesList = [
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
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(8);
  static const String defaultValueField = 'value';
  static const String defaultdisplayedField = 'display';
  static const Alignment defaultAlign = Alignment.topCenter;
  static const double defaultInnerSpace = 10.0;
  static const bool defaultUnderline = false;
  static const Color defaultDashColor = KenModel.kBack100;

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
  Color? dashColor;

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
    this.backColor = defaultBackColor,
    this.fontSize = defaultFontSize,
    this.fontColor = defaultFontColor,
    this.fontBold = defaultFontBold,
    this.borderColor = defaultBorderColor,
    this.borderWidth = defaultBorderWidth,
    this.borderRadius = defaultBorderRadius,
    this.elevation = defaultElevation,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultCaptionFontColor,
    this.captionBackColor = defaultCaptionBackColor,
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
    this.dashColor = defaultDashColor,
    title = '',
    this.minutesList = defaultMinutesList,
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    id = KenUtilities.getWidgetId('FLD', id);
  }

  KenTimePickerModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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
    dashColor = KenUtilities.getColorFromRGB(optionsDefault!['dashColor']) ??
        defaultDashColor;
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
        await getData();
      };
    }
  }
}
