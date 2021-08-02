import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_list_box_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_component_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

enum SmeupListType { simple, oriented, wheel }

class SmeupListBoxModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 0;
  static const double defaultHeight = 100;
  static const double defaultListHeight = 100;
  static const double defaultPadding = 0.0;
  static const SmeupListType defaultListType = SmeupListType.oriented;
  static const int defaultPortraitColumns = 1;
  static const int defaultLandscapeColumns = 1;
  static const String defaultLayout = '1';

  double width;
  double height;
  double listHeight;
  Axis orientation;
  double padding;
  double paddingRight;
  double paddingLeft;
  SmeupListType listType;
  int portraitColumns;
  int landscapeColumns;

  SmeupListBoxModel(
      {layout = defaultLayout,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.listHeight = defaultHeight,
      this.orientation,
      this.padding = defaultPadding,
      this.paddingRight = defaultPadding,
      this.paddingLeft = defaultPadding,
      this.listType = defaultListType,
      this.portraitColumns = defaultPortraitColumns,
      this.landscapeColumns = defaultLandscapeColumns,
      title = ''})
      : super(title: title) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupListBoxModel.fromMap(Map<String, dynamic> jsonMap)
      : super.fromMap(jsonMap) {
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

    padding =
        SmeupUtilities.getDouble(optionsDefault['padding']) ?? defaultPadding;
    paddingRight = SmeupUtilities.getDouble(optionsDefault['paddingRight']) ??
        defaultPadding;
    paddingLeft = SmeupUtilities.getDouble(optionsDefault['paddingLeft']) ??
        defaultPadding;
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;
    listHeight = SmeupUtilities.getDouble(optionsDefault['listHeight']) ??
        defaultListHeight;
    listType = decodeListType(optionsDefault['listType']);
    orientation = jsonMap['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;

    if (widgetLoadType != LoadType.Delay) {
      SmeupListBoxDao.getData(this).then((value) {
        data = value;
      });
    }

    SmeupDataService.incrementDataFetch(id);
  }

  SmeupListType decodeListType(String type) {
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
