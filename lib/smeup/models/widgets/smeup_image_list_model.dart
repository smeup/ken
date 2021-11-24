import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageListModel extends SmeupModel implements SmeupDataInterface {
  // supported by json_theme
  static double defaultCaptionFontSize;
  static Color defaultCaptionFontColor;
  static Color defaultCaptionBackColor;
  static bool defaultCaptionFontBold;

  // unsupported by json_theme
  static const double defaultWidth = 0;
  static const double defaultHeight = 300;
  static const EdgeInsetsGeometry defaultPadding = EdgeInsets.all(0);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const String defaultLayout = '1';
  static const Axis defaultOrientation = Axis.vertical;
  static const double defaultListHeight = 0;

  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  bool captionFontBold;

  double width;
  double height;
  Axis orientation;
  EdgeInsetsGeometry padding;
  int columns;
  int rows;
  String layout = '';
  double listHeight;

  SmeupImageListModel(
      {id,
      type,
      GlobalKey<FormState> formKey,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.captionFontBold,
      layout = defaultLayout,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.padding = defaultPadding,
      this.columns = defaultColumns,
      this.listHeight = defaultListHeight,
      this.orientation = defaultOrientation,
      this.rows = defaultRows,
      title = ''})
      : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
    setDefaults(this);
  }

  SmeupImageListModel.fromMap(
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
    columns =
        SmeupUtilities.getInt(optionsDefault['columns']) ?? defaultColumns;
    rows = SmeupUtilities.getInt(optionsDefault['rows']) ?? defaultRows;
    if (columns == 0 && rows == 0) {
      columns = 1;
    }
    captionFontSize = optionsDefault['fontSize'] ?? defaultCaptionFontSize;
    captionBackColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
            defaultCaptionBackColor;

    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
            defaultCaptionFontColor;

    captionFontBold = optionsDefault['bold'] ?? defaultCaptionFontBold;
    padding =
        SmeupUtilities.getPadding(optionsDefault['padding']) ?? defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupListBoxDao.getData(this);
      };
    }

    SmeupDataService.incrementDataFetch(id);
  }

  static setDefaults(dynamic obj) {
    var captionStyle = SmeupConfigurationService.getTheme().textTheme.caption;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;
    defaultCaptionBackColor = captionStyle.backgroundColor;

    // ----------------- set properties from default

    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupImageListModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupImageListModel.defaultCaptionFontSize;
    if (obj.captionBackColor == null)
      obj.captionBackColor = SmeupImageListModel.defaultCaptionBackColor;
    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupImageListModel.defaultCaptionFontBold;
  }
}
