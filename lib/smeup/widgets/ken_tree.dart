import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';

class KenTree extends StatelessWidget {
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
    this.width = KenTreeDefaults.defaultWidth,
    this.height = KenTreeDefaults.defaultHeight,
    this.labelFontSize = KenTreeDefaults.defaultLabelFontSize,
    this.labelBackColor = KenTreeDefaults.defaultLabelBackColor,
    this.labelFontColor = KenTreeDefaults.defaultLabelFontColor,
    this.labelFontbold = KenTreeDefaults.defaultLabelFontbold,
    this.labelVerticalSpacing = KenTreeDefaults.defaultLabelVerticalSpacing,
    this.labelHeight = KenTreeDefaults.defaultLabelHeight,
    this.parentFontSize = KenTreeDefaults.defaultParentFontSize,
    this.parentBackColor = KenTreeDefaults.defaultParentBackColor,
    this.parentFontColor = KenTreeDefaults.defaultParentFontColor,
    this.parentFontbold = KenTreeDefaults.defaultParentFontbold,
    this.parentVerticalSpacing = KenTreeDefaults.defaultParentVerticalSpacing,
    this.parentHeight = KenTreeDefaults.defaultParentHeight,
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
