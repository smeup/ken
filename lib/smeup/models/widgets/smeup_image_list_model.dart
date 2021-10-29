import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageListModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const double defaultListHeight = 100;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const String defaultLayout = '1';
  static const double defaultFontsize = 16.0;
  static const Axis defaultOrientation = Axis.vertical;

  double width;
  double height;
  double listHeight;
  Axis orientation;
  EdgeInsetsGeometry padding;
  int columns;
  int rows;
  double fontsize;
  String layout = '';

  SmeupImageListModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      layout = defaultLayout,
      this.fontsize = defaultFontsize,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.listHeight = defaultHeight,
      this.padding = defaultPadding,
      this.columns = defaultColumns,
      this.orientation = defaultOrientation,
      this.rows = defaultRows,
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
    columns =
        SmeupUtilities.getInt(optionsDefault['columns']) ?? defaultColumns;
    rows = SmeupUtilities.getInt(optionsDefault['rows']) ?? defaultRows;
    if (columns == 0 && rows == 0) {
      columns = 1;
    }
    fontsize = optionsDefault['fontSize'] ?? defaultFontsize;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupListBoxDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }
}
