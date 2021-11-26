import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupImageListModel extends SmeupModel implements SmeupDataInterface {
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
  static const double defaultHeight = 300;
  static const EdgeInsetsGeometry defaultPadding =
      EdgeInsets.only(left: 5, right: 5);
  static const int defaultColumns = 0;
  static const int defaultRows = 0;
  static const Axis defaultOrientation = Axis.vertical;
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
  int columns;
  int rows;
  double listHeight;

  SmeupImageListModel(
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

    title = jsonMap['title'] ?? '';
    columns =
        SmeupUtilities.getInt(optionsDefault['columns']) ?? defaultColumns;
    rows = SmeupUtilities.getInt(optionsDefault['rows']) ?? defaultRows;
    if (columns == 0 && rows == 0) {
      columns = 1;
    }
    fontSize = optionsDefault['fontSize'] ?? defaultFontSize;
    fontColor = SmeupUtilities.getColorFromRGB(optionsDefault['fontColor']) ??
        defaultFontColor;
    fontBold = optionsDefault['bold'] ?? defaultFontBold;

    backColor = SmeupUtilities.getColorFromRGB(optionsDefault['backColor']) ??
        defaultBackColor;

    captionFontSize =
        SmeupUtilities.getDouble(optionsDefault['captionFontSize']) ??
            defaultCaptionFontSize;
    captionFontColor =
        SmeupUtilities.getColorFromRGB(optionsDefault['captionFontColor']) ??
            defaultCaptionFontColor;
    captionFontBold = optionsDefault['captionBold'] ?? defaultCaptionFontBold;

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
        .headline1
        .copyWith(backgroundColor: defaultBackColor);
    defaultFontBold = textStyle.fontWeight == FontWeight.bold;
    defaultFontSize = textStyle.fontSize;
    defaultFontColor = textStyle.color;

    var captionStyle = SmeupConfigurationService.getTheme().textTheme.headline2;
    defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
    defaultCaptionFontSize = captionStyle.fontSize;
    defaultCaptionFontColor = captionStyle.color;

    // ----------------- set properties from default
    if (obj.backColor == null)
      obj.backColor = SmeupImageListModel.defaultBackColor;

    if (obj.borderColor == null)
      obj.borderColor = SmeupImageListModel.defaultBorderColor;
    if (obj.borderWidth == null)
      obj.borderWidth = SmeupImageListModel.defaultBorderWidth;
    if (obj.borderRadius == null)
      obj.borderRadius = SmeupImageListModel.defaultBorderRadius;

    if (obj.fontBold == null)
      obj.fontBold = SmeupImageListModel.defaultFontBold;
    if (obj.fontColor == null)
      obj.fontColor = SmeupImageListModel.defaultFontColor;
    if (obj.fontSize == null)
      obj.fontSize = SmeupImageListModel.defaultFontSize;

    if (obj.captionFontBold == null)
      obj.captionFontBold = SmeupImageListModel.defaultCaptionFontBold;
    if (obj.captionFontColor == null)
      obj.captionFontColor = SmeupImageListModel.defaultCaptionFontColor;
    if (obj.captionFontSize == null)
      obj.captionFontSize = SmeupImageListModel.defaultCaptionFontSize;
  }
}
