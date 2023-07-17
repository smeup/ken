import 'package:flutter/material.dart';
import '../../services/ken_utilities.dart';
import 'ken_data_interface.dart';
import 'ken_model.dart';
import 'ken_model_callback.dart';

class KenTreeModel extends KenModel implements KenDataInterface {
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

  double? width;
  double? height;
  double? labelFontSize;
  Color? labelBackColor;
  Color? labelFontColor;
  bool? labelFontbold;
  double? labelVerticalSpacing;
  double? labelHeight;
  double? parentFontSize;
  Color? parentBackColor;
  Color? parentFontColor;
  bool? parentFontbold;
  double? parentVerticalSpacing;
  double? parentHeight;

  KenTreeModel({
    id,
    type,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
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
    required Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  }) : super(formKey, scaffoldKey, context,
            title: title,
            id: id,
            type: type,
            instanceCallBack: instanceCallBack);

  KenTreeModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    Function(ServicesCallbackType type, Map<dynamic, dynamic>? jsonMap,
            KenModel? instance)
        instanceCallBack,
  ) : super.fromMap(jsonMap, formKey, scaffoldKey, context, instanceCallBack) {
    width = KenUtilities.getDouble(optionsDefault!['width']) ?? defaultWidth;
    height = KenUtilities.getDouble(optionsDefault!['height']) ?? defaultHeight;

    if (widgetLoadType != LoadType.Delay) {
      onReady = () async {
        // await SmeupTreeDao.getData(this);
        await getData();
      };
    }
  }
}
