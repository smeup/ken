// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenImageListModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBackColor = Colors.white;
  static Color? defaultBorderColor = KenModel.kButtonBackgroundColor;
  static double? defaultBorderWidth = 2;
  static double? defaultBorderRadius = 20;
  static double? defaultFontSize = 12;
  static Color? defaultFontColor = KenModel.kButtonBackgroundColor;
  static bool? defaultFontBold = false;
  static bool? defaultCaptionFontBold = false;
  static double? defaultCaptionFontSize = 10;
  static Color? defaultCaptionFontColor = KenModel.kButtonBackgroundColor;

  // unsupported by json_theme
  static const double defaultWidth = 200;
  static const double defaultHeight = 200;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const Axis defaultOrientation = Axis.vertical;
  static const double defaultListHeight = 480;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;

  double? width;
  double? height;
  Axis? orientation;
  EdgeInsetsGeometry? padding;
  int? columns;
  int? rows;
  double? listHeight;

  KenImageListModel(
      {id,
      type,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      this.backColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.fontSize,
      this.fontColor,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.columns = defaultColumns,
      this.listHeight = defaultListHeight,
      this.orientation = defaultOrientation,
      this.rows = defaultRows,
      title = ''})
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    setDefaults(this);
  }

  KenImageListModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    title = jsonMap['title'] ?? '';
    columns = KenUtilities.getInt(optionsDefault!['columns']) ?? defaultColumns;
    rows = KenUtilities.getInt(optionsDefault!['rows']) ?? defaultRows;
    if (columns == 0 && rows == 0) {
      columns = 1;
    }
    fontSize = optionsDefault!['fontSize'] ?? defaultFontSize;
    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    listHeight = KenUtilities.getDouble(optionsDefault!['listHeight']) ??
        defaultListHeight;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupListBoxDao.getData(this);
        await getData();
      };
    }
  }

  static setDefaults(dynamic obj) {
    var cardTheme = KenConfigurationService.getTheme()!.cardTheme;
    defaultBackColor = cardTheme.color;
    ContinuousRectangleBorder shape =
        cardTheme.shape as ContinuousRectangleBorder;
    defaultBorderRadius =
        shape.borderRadius.resolve(TextDirection.ltr).topLeft.x;
    var side = shape.side;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var textStyle = KenConfigurationService.getTheme()!
        .textTheme
        .headline4!
        .copyWith(backgroundColor: defaultBackColor);
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = KenConfigurationService.getTheme()!.textTheme.headline5!;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    obj.backColor ??= KenImageListModel.defaultBackColor;

    obj.borderColor ??= KenImageListModel.defaultBorderColor;
    obj.borderWidth ??= KenImageListModel.defaultBorderWidth;
    obj.borderRadius ??= KenImageListModel.defaultBorderRadius;

    obj.fontBold ??= KenImageListModel.defaultFontBold;
    obj.fontColor ??= KenImageListModel.defaultFontColor;
    obj.fontSize ??= KenImageListModel.defaultFontSize;

    obj.captionFontBold ??= KenImageListModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenImageListModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenImageListModel.defaultCaptionFontSize;
  }
}
