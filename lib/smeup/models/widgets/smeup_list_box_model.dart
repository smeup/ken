import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum SmeupListType { simple, oriented, wheel }

class SmeupListBoxModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 200;
  static const double defaultListHeight = 200;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(5);
  static const SmeupListType defaultListType = SmeupListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '1';
  static const double defaultFontsize = 16.0;
  static const Axis defaultOrientation = Axis.vertical;
  static const String defaultDefaultSort = '';
  static const String defaultBackgroundColName = '';
  static const bool defaultShowSelection = false;
  static const int defaultSelectedRow = -1;
  static const Color defaultBackColor = Colors.white;
  static const Color defaultFontColor = Colors.black;

  double width;
  double height;
  double listHeight;
  Axis orientation;
  EdgeInsetsGeometry padding;
  SmeupListType listType;
  int portraitColumns;
  int landscapeColumns;
  double fontsize;
  String layout = '';
  List<String> visibleColumns;
  String defaultSort;
  Color backColor;
  Color fontColor;
  String backgroundColName;
  bool showSelection;
  int selectedRow;

  SmeupListBoxModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.layout = defaultLayout,
      this.fontsize = defaultFontsize,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.listHeight = defaultHeight,
      this.orientation = defaultOrientation,
      this.padding = defaultPadding,
      this.listType = defaultListType,
      this.portraitColumns = defaultPortraitColumns,
      this.landscapeColumns = defaultLandscapeColumns,
      this.visibleColumns,
      this.defaultSort = defaultDefaultSort,
      this.fontColor = defaultFontColor,
      this.backColor = defaultBackColor,
      this.backgroundColName = defaultBackgroundColName,
      this.showSelection = defaultShowSelection,
      this.selectedRow = defaultSelectedRow,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
    if (visibleColumns == null)
      visibleColumns = List<String>.empty(growable: true);
  }

  SmeupListBoxModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
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
    fontsize = optionsDefault['fontSize'] ?? defaultFontsize;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;
    listType = decodeListType(optionsDefault['listType']);
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (optionsDefault['columns'] != null) {
      visibleColumns = optionsDefault['columns'].split('|');
    } else {
      visibleColumns = List<String>.empty(growable: true);
    }

    if (optionsDefault['fontColor'] != null) {
      fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']);
    }
    if (optionsDefault['backColor'] != null) {
      backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']);
    }

    backgroundColName = optionsDefault['backgroundColName'];
    defaultSort = optionsDefault['defaultSort'] ?? defaultDefaultSort;

    showSelection =
        SmeupUtilities.getBool(optionsDefault['showSelection']) ?? false;

    selectedRow = -1;
    if (optionsDefault['selectRow'] != null) {
      selectedRow = SmeupUtilities.getInt(optionsDefault['selectRow']);
    }

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
}
