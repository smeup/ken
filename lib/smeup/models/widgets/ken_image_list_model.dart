// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import '../../services/ken_configuration_service.dart';

class KenImageListModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultBackColor = Colors.white;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 2;
  static const double defaultBorderRadius = 20;
  static const double defaultFontSize = 12;
  static const Color defaultFontColor = KenModel.kPrimary;
  static const bool defaultFontBold = false;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 10;
  static const Color defaultCaptionFontColor = KenModel.kPrimary;
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
      : super(formKey, scaffoldKey, context, title: title, id: id, type: type);

  KenImageListModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context)
      : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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
}
