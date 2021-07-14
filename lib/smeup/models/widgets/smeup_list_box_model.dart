import 'package:flutter/material.dart';
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
  static const SmeupListType defaultListType = SmeupListType.simple;

  int portraitColumns;
  int landscapeColumns;
  List<String> boxColumnNames;
  double width;
  double height;
  double listHeight;
  Axis orientation;
  double padding;
  double paddingRight;
  double paddingLeft;
  SmeupListType listType;

  String boxLayout;

  SmeupListBoxModel(
      {this.portraitColumns,
      this.landscapeColumns,
      this.boxLayout,
      this.boxColumnNames,
      this.width = defaultWidth,
      this.height = defaultHeight,
      this.listHeight = defaultHeight,
      this.orientation,
      this.padding = defaultPadding,
      this.paddingRight = defaultPadding,
      this.paddingLeft = defaultPadding,
      this.listType = defaultListType,
      title = ''})
      : super(title: title) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupListBoxModel.fromMap(response,
      {this.portraitColumns,
      this.landscapeColumns,
      this.boxLayout,
      this.boxColumnNames})
      : super.fromMap(response) {
    //boxLayout = response['layout'] ?? 'default1';
    boxLayout = '';
    if (response['layout'] != null) {
      final String layout = response['layout'].toString();
      if (layout != null && layout.length > 0) {
        boxLayout = layout.substring(layout.length - 1);
      }
    }

    title = response['title'] ?? '';
    if (optionsDefault['Cols'] != null) {
      portraitColumns = optionsDefault['Cols'];
      landscapeColumns = optionsDefault['Cols'];
    } else {
      portraitColumns = 0;
      landscapeColumns = 0;
    }
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
    orientation = response['orientation'] == 'horizontal'
        ? Axis.horizontal
        : Axis.vertical;
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
        return SmeupListType.simple;
    }
  }

  @override
  setData() async {
    if (smeupFun != null && smeupFun.isFunValid()) {
      final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

      if (!smeupServiceResponse.succeded) {
        return;
      }

      data = smeupServiceResponse.result.data;
    }
    SmeupDataService.decrementDataFetch(id);
  }
}
