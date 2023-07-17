// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';
import '../../services/ken_configuration_service.dart';

enum KenListType { simple, oriented, wheel }

class KenListBoxModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static Color? defaultBackColor = Colors.transparent;
  static Color? defaultBorderColor;
  static double? defaultBorderWidth;
  static double? defaultBorderRadius = 8;
  static double? defaultFontSize = 16;
  static Color? defaultFontColor;
  static bool? defaultFontBold = true;
  static bool? defaultCaptionFontBold;
  static double? defaultCaptionFontSize;
  static Color? defaultCaptionFontColor;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const KenListType defaultListType = KenListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '2';
  static const Axis defaultOrientation = Axis.vertical;
  static const String defaultDefaultSort = '';
  static const String defaultBackgroundColName = '';
  static const bool defaultShowSelection = false;
  static const int defaultSelectedRow = 1;
  static const double defaultListHeight = 300;

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
  KenListType? listType;
  int? portraitColumns;
  int? landscapeColumns;
  String layout = '';
  List<String>? visibleColumns;
  String? defaultSort;
  String? backgroundColName;
  bool? showSelection;
  int? selectedRow;
  double? listHeight;

  KenListBoxModel({
    id,
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
    this.layout = defaultLayout,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.orientation = defaultOrientation,
    this.padding = defaultPadding,
    this.listType = defaultListType,
    this.portraitColumns = defaultPortraitColumns,
    this.landscapeColumns = defaultLandscapeColumns,
    this.visibleColumns,
    this.defaultSort = defaultDefaultSort,
    this.listHeight = defaultListHeight,
    this.backgroundColName = defaultBackgroundColName,
    this.showSelection = defaultShowSelection,
    this.selectedRow = defaultSelectedRow,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    visibleColumns ??= List<String>.empty(growable: true);
    setDefaults(this);
  }

  KenListBoxModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
    setDefaults(this);

    layout = defaultLayout;
    if (jsonMap['layout'] != null) {
      layout = jsonMap['layout'].toString();
      if (layout.isNotEmpty) {
        layout = layout.substring(layout.length - 1);
      }
    }

    title = jsonMap['title'] ?? '';
    layout = optionsDefault!['Layout'] ?? defaultLayout;
    portraitColumns = KenUtilities.getInt(optionsDefault!['portraitColumns']) ??
        defaultPortraitColumns;
    landscapeColumns =
        KenUtilities.getInt(optionsDefault!['landscapeColumns']) ??
            defaultLandscapeColumns;

    padding =
        KenUtilities.getPadding(optionsDefault!['padding']) ?? defaultPadding;
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;
    listType = decodeListType(optionsDefault!['listType']);
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (optionsDefault!['columns'] != null) {
      visibleColumns = optionsDefault!['columns'].split('|');
    } else {
      visibleColumns = List<String>.empty(growable: true);
    }

    fontSize = optionsDefault!['fontSize'] ?? defaultFontSize;
    fontColor = KenUtilities.getColorFromRGB(optionsDefault!['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault!['bold'] ?? defaultFontBold;

    backColor = KenUtilities.getColorFromRGB(optionsDefault!['backColor']) ??
        defaultBackColor;

    backgroundColName = optionsDefault!['backgroundColName'];
    defaultSort = optionsDefault!['defaultSort'] ?? defaultDefaultSort;

    showSelection =
        KenUtilities.getBool(optionsDefault!['showSelection']) ?? false;

    selectedRow = -1;
    if (optionsDefault!['selectRow'] != null) {
      selectedRow = KenUtilities.getInt(optionsDefault!['selectRow']);
    }

    listHeight = KenUtilities.getDouble(optionsDefault!['listHeight']) ??
        defaultListHeight;

    borderRadius = KenUtilities.getDouble(optionsDefault!['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = KenUtilities.getDouble(optionsDefault!['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        KenUtilities.getColorFromRGB(optionsDefault!['borderColor']) ??
            defaultBorderColor;

    captionFontSize =
        KenUtilities.getDouble(optionsDefault!['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        KenUtilities.getColorFromRGB(optionsDefault!['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault!['captionBold'] ?? defaultCaptionFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupListBoxDao.getData(this);
        await getData();
      };
    }
  }

  static KenListType decodeListType(String? type) {
    switch (type) {
      case 'simple':
        return KenListType.simple;
      case 'oriented':
        return KenListType.oriented;
      case 'wheel':
        return KenListType.wheel;
      default:
        return defaultListType;
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
    obj.backColor ??= KenListBoxModel.defaultBackColor;

    obj.borderColor ??= KenListBoxModel.defaultBorderColor;
    obj.borderWidth ??= KenListBoxModel.defaultBorderWidth;
    obj.borderRadius ??= KenListBoxModel.defaultBorderRadius;

    obj.fontBold ??= KenListBoxModel.defaultFontBold;
    obj.fontColor ??= KenListBoxModel.defaultFontColor;
    obj.fontSize ??= KenListBoxModel.defaultFontSize;

    obj.captionFontBold ??= KenListBoxModel.defaultCaptionFontBold;
    obj.captionFontColor ??= KenListBoxModel.defaultCaptionFontColor;
    obj.captionFontSize ??= KenListBoxModel.defaultCaptionFontSize;
  }
}
