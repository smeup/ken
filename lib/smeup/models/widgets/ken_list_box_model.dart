import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model_callback.dart';
import 'package:ken/smeup/models/widgets/ken_data_interface.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';

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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack) {
    if (visibleColumns == null)
      visibleColumns = List<String>.empty(growable: true);
    setDefaults(this);
  }

  KenListBoxModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    setDefaults(this);

    layout = defaultLayout;
    if (jsonMap['layout'] != null) {
      layout = jsonMap['layout'].toString();
      if (layout.length > 0) {
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
        await this.getData(instanceCallBack);
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
    if (obj.backColor == null) obj.backColor = KenListBoxModel.defaultBackColor;

    if (obj.borderColor == null)
      obj.borderColor = KenListBoxModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = KenListBoxModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = KenListBoxModel.defaultBorderRadius;

    if (obj.fontBold == null) obj.fontBold = KenListBoxModel.defaultFontBold;
    if (obj.fontColor == null) obj.fontColor = KenListBoxModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = KenListBoxModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = KenListBoxModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = KenListBoxModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = KenListBoxModel.defaultCaptionFontSize;
  }
}
