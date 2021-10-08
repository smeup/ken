import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_list_box_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageListModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const double defaultListHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const SmeupListType defaultListType = SmeupListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '1';
  static const double defaultFontsize = 16.0;
  static const Axis defaultOrientation = Axis.vertical;

  double width;
  double height;
  double listHeight;
  Axis orientation;
  EdgeInsetsGeometry padding;
  SmeupListType listType;
  int portraitColumns;
  int landscapeColumns;
  double fontsize;

  SmeupImageListModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      layout = defaultLayout,
      this.fontsize = defaultFontsize,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.listHeight = defaultHeight,
      this.orientation = defaultOrientation,
      this.padding = defaultPadding,
      this.listType = defaultListType,
      this.portraitColumns = defaultPortraitColumns,
      this.landscapeColumns = defaultLandscapeColumns,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupImageListModel.fromMap(
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
    portraitColumns =
        SmeupUtilities.getInt(optionsDefault['portraitColumns']) ??
            defaultPortraitColumns;
    landscapeColumns =
        SmeupUtilities.getInt(optionsDefault['landscapeColumns']) ??
            defaultLandscapeColumns;
    fontsize = optionsDefault['fontSize'] ?? defaultFontsize;
    padding = SmeupUtilities.getPadding(optionsDefault['padding']);
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;
    listType = SmeupListBoxModel.decodeListType(optionsDefault['listType']);
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (widgetLoadType != LoadType.Delay) {
      SmeupListBoxDao.getData(this);
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
