import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

import '../../services/ken_configuration_service.dart';

class KenImageListModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBackColor;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius;
  static double? defaultFontSize;
  static Color? defaultFontColor;
  static bool? defaultFontBold;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 300;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const Axis defaultOrientation = Axis.vertical;
  static const double defaultListHeight = 0;

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
      title = '',
      required Function(ServicesCallbackType type,
              Map<dynamic, dynamic>? jsonMap, KenModel? instance)
          instanceCallBack})
      : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    setDefaults(this);
  }

  KenImageListModel.fromMap(
      Map<String, dynamic> jsonMap,
      GlobalKey<FormState>? formKey,
      GlobalKey<ScaffoldState>? scaffoldKey,
      BuildContext? context,
      Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
              KenModel? instance)
          instanceCallBack)
      : super.fromMap(
            jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
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
        await this.getData();
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
    if (obj.backColor == null)
      obj.backColor = KenImageListModel.defaultBackColor;

    if (obj.borderColor == null)
      obj.borderColor = KenImageListModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenImageListModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenImageListModel.defaultBorderRadius;

    if (obj.fontBold == null) obj.fontBold = KenImageListModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = KenImageListModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = KenImageListModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = KenImageListModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenImageListModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenImageListModel.defaultCaptionFontSize;
  }
}
