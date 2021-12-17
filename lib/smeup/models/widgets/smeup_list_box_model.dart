import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum SmeupListType { simple, oriented, wheel }

class SmeupListBoxModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static Color defaultBackColor;
  static Color defaultBorderColor;
  static double defaultBorderWidth;
  static double defaultBorderRadius;
  static double defaultFontSize;
  static Color defaultFontColor;
  static bool defaultFontBold;
  static bool defaultCaptionFontBold;
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 170;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const SmeupListType defaultListType = SmeupListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '1';
  static const Axis defaultOrientation = Axis.vertical;
  static const String defaultDefaultSort = '';
  static const String defaultBackgroundColName = '';
  static const bool defaultShowSelection = false;
  static const int defaultSelectedRow = -1;
  static const double defaultListHeight = 0;

  Color backColor;
  Color borderColor;
  double borderWidth;
  double borderRadius;
  double fontSize;
  Color fontColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;

  double width;
  double height;
  Axis orientation;
  EdgeInsetsGeometry padding;
  SmeupListType listType;
  int portraitColumns;
  int landscapeColumns;
  String layout = '';
  List<String> visibleColumns;
  String defaultSort;
  String backgroundColName;
  bool showSelection;
  int selectedRow;
  double listHeight;

  SmeupListBoxModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
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
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
    if (visibleColumns == null)
      visibleColumns = List<String>.empty(growable: true);
    setDefaults(this);
  }

  SmeupListBoxModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    setDefaults(this);

    layout = defaultLayout;
    if (jsonMap['layout'] != null) {
      layout = jsonMap['layout'].toString();
      if (layout != null && layout.length > 0) {
        layout = layout.substring(layout.length - 1);
      }
    }

    title = jsonMap['title'] ?? '';
    layout = optionsDefault['Layout'] ?? defaultLayout;
    portraitColumns =
        SmeupUtilities.getInt(optionsDefault['portraitColumns']) ??
            defaultPortraitColumns;
    landscapeColumns =
        SmeupUtilities.getInt(optionsDefault['landscapeColumns']) ??
            defaultLandscapeColumns;

    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    listType = decodeListType(optionsDefault['listType']);
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (optionsDefault['columns'] != null) {
      visibleColumns = optionsDefault['columns'].split('|');
    } else {
      visibleColumns = List<String>.empty(growable: true);
    }

    fontSize = optionsDefault['fontSize'] ?? defaultFontSize;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    backgroundColName = optionsDefault['backgroundColName'];
    defaultSort = optionsDefault['defaultSort'] ?? defaultDefaultSort;

    showSelection =
        SmeupUtilities.getBool(optionsDefault['showSelection']) ?? false;

    selectedRow = -1;
    if (optionsDefault['selectRow'] != null) {
      selectedRow = SmeupUtilities.getInt(optionsDefault['selectRow']);
    }

    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;

    borderRadius = SmeupUtilities.getDouble(optionsDefault['borderRadius']) ??
        defaultBorderRadius;
    borderWidth = SmeupUtilities.getDouble(optionsDefault['borderWidth']) ??
        defaultBorderWidth;
    borderColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['borderColor']) ??
            defaultBorderColor;

    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupListBoxDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static SmeupListType decodeListType(String type) {
    switch (type) {
      case 'simple':
        return SmeupListType.simple;
      case 'oriented':
        return SmeupListType.oriented;
      case 'wheel':
        return SmeupListType.wheel;
      default:
        return defaultListType;
    }
  }

  static setDefaults(dynamic obj) {
    var cardTheme = SmeupConfigurationService.getTheme().cardTheme;
    defaultBackColor = cardTheme.color;
    ContinuousRectangleBorder shape = cardTheme.shape;
    defaultBorderRadius =
        shape.borderRadius.resolve(TextDirection.ltr).topLeft.x;
    var side = shape.side;
    defaultBorderColor = side.color;
    defaultBorderWidth = side.width;

    var textStyle = SmeupConfigurationService.getTheme()
        .textTheme
        .headline4
        .copyWith(backgroundColor: defaultBackColor);
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.headline5;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    if (obj.backColor == null)
      obj.backColor = SmeupListBoxModel.defaultBackColor;

    if (obj.borderColor == null)
      obj.borderColor = SmeupListBoxModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupListBoxModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupListBoxModel.defaultBorderRadius;

    if (obj.fontBold == null) obj.fontBold = SmeupListBoxModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupListBoxModel.defaultFontColor;
    if (obj.fontSize == null) obj.fontSize = SmeupListBoxModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupListBoxModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupListBoxModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupListBoxModel.defaultCaptionFontSize;
  }
}
