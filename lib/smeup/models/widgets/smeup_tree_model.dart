import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_tree_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_data_interface.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';

class SmeupTreeModel extends SmeupModel implements SmeupDataInterface {
  static const double defaultWidth = 100;
  static const double defaultHeight = 100;

  static const double defaultLabelFontSize = 16;
  static const Color defaultLabelBackColor = Colors.white;
  static const Color defaultLabelFontColor = Colors.black;
  static const bool defaultLabelFontbold = false;
  static const double defaultLabelVerticalSpacing = 2;
  static const double defaultLabelHeight = 10;

  static const double defaultParentFontSize = 20;
  static const Color defaultParentBackColor = Colors.white;
  static const Color defaultParentFontColor = Colors.black;
  static const bool defaultParentFontbold = true;
  static const double defaultParentVerticalSpacing = 2;
  static const double defaultParentHeight = 10;

  double width;
  double height;
  double labelFontSize;
  Color labelBackColor;
  Color labelFontColor;
  bool labelFontbold;
  double labelVerticalSpacing;
  double labelHeight;
  double parentFontSize;
  Color parentBackColor;
  Color parentFontColor;
  bool parentFontbold;
  double parentVerticalSpacing;
  double parentHeight;

  SmeupTreeModel({
    id,
    type,
    GlobalKey<FormState> formKey,
    title = '',
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.labelFontSize = defaultLabelFontSize,
    this.labelBackColor = defaultLabelBackColor,
    this.labelFontColor = defaultLabelFontColor,
    this.labelFontbold = defaultLabelFontbold,
    this.labelVerticalSpacing = defaultLabelVerticalSpacing,
    this.labelHeight = defaultLabelHeight,
    this.parentFontSize = defaultParentFontSize,
    this.parentBackColor = defaultParentBackColor,
    this.parentFontColor = defaultParentFontColor,
    this.parentFontbold = defaultParentFontbold,
    this.parentVerticalSpacing = defaultParentVerticalSpacing,
    this.parentHeight = defaultParentHeight,
  }) : super(formKey, title: title, id: id, type: type) {
    SmeupDataService.incrementDataFetch(id);
  }

  SmeupTreeModel.fromMap(
      Map<String, dynamic> jsonMap, GlobalKey<FormState> formKey)
      : super.fromMap(jsonMap, formKey) {
    width = SmeupUtilities.getDouble(optionsDefault['width']) ?? defaultWidth;
    height =
        SmeupUtilities.getDouble(optionsDefault['height']) ?? defaultHeight;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        await SmeupTreeDao.getData(this);
      };
    }
    SmeupDataService.incrementDataFetch(id);
  }
}
