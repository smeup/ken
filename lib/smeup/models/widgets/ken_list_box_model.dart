// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';

import '../../services/ken_configuration_service.dart';

enum KenListType { simple, oriented, wheel }

class KenListBoxModel extends KenModel implements KenDataInterface {
  // supported by json_theme
  static const Color defaultBackColor = KenModel.kBack100;
  static const Color defaultBorderColor = KenModel.kPrimary;
  static const double defaultBorderWidth = 1;
  static const double defaultBorderRadius = 8.0;
  static const double defaultFontSize = 12;
  static const Color defaultFontColor = KenModel.kSecondary100;
  static const bool defaultFontBold = true;
  static const bool defaultCaptionFontBold = false;
  static const double defaultCaptionFontSize = 12;
  static const Color defaultCaptionFontColor = KenModel.kSecondary100;
  static const double defaultWidth = 0;
  static const double defaultHeight = 130;
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
  static const double defaultRealBoxHeight = 400;

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
  double? realBoxHeight;
  double? listHeight;

  KenListBoxModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    this.backColor = defaultBackColor,
    this.borderColor = defaultBorderColor,
    this.borderWidth = defaultBorderWidth,
    this.borderRadius = defaultBorderRadius,
    this.fontSize = defaultFontSize,
    this.fontColor = defaultFontColor,
    this.fontBold = defaultFontBold,
    this.captionFontBold = defaultCaptionFontBold,
    this.captionFontSize = defaultCaptionFontSize,
    this.captionFontColor = defaultCaptionFontColor,
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
    this.realBoxHeight = defaultRealBoxHeight,
    title = '',
  }) : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
    visibleColumns ??= List<String>.empty(growable: true);
  }

  KenListBoxModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context) {
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

    realBoxHeight = KenUtilities.getDouble(optionsDefault!['realBoxHeight']) ??
        defaultRealBoxHeight;

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
}
