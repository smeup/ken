import 'package:flutter/material.dart';
import '../models/widgets/ken_tree_model.dart';
import '../services/ken_utilities.dart';

// ignore: must_be_immutable
class KenTree extends StatelessWidget {
  KenTreeModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  List<dynamic>? data;
  String? title;
  String? id;
  String? type;
  Function? onClientClick;
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
  double? parentWidth;

  KenTree(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'TRE',
    this.title = '',
    this.data = const [],
    this.onClientClick,
    this.width = KenTreeModel.defaultWidth,
    this.height = KenTreeModel.defaultHeight,
    this.labelFontSize = KenTreeModel.defaultLabelFontSize,
    this.labelBackColor = KenTreeModel.defaultLabelBackColor,
    this.labelFontColor = KenTreeModel.defaultLabelFontColor,
    this.labelFontbold = KenTreeModel.defaultLabelFontbold,
    this.labelVerticalSpacing = KenTreeModel.defaultLabelVerticalSpacing,
    this.labelHeight = KenTreeModel.defaultLabelHeight,
    this.parentFontSize = KenTreeModel.defaultParentFontSize,
    this.parentBackColor = KenTreeModel.defaultParentBackColor,
    this.parentFontColor = KenTreeModel.defaultParentFontColor,
    this.parentFontbold = KenTreeModel.defaultParentFontbold,
    this.parentVerticalSpacing = KenTreeModel.defaultParentVerticalSpacing,
    this.parentHeight = KenTreeModel.defaultParentHeight,
  });
  @override
  Widget build(BuildContext context) {
    Widget? children;

    double? treeHeight = height;
    double? treeWidth = width;
    if (parentWidth != null && parentHeight != null) {
      if (treeHeight == 0) {
        treeHeight = parentHeight;
      }
      if (treeWidth == 0) treeWidth = parentWidth;
    } else {
      if (treeHeight == 0) treeHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (treeWidth == 0) treeWidth = KenUtilities.getDeviceInfo().safeWidth;
    }
    return children ?? Container();
  }
}
