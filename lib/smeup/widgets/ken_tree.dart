import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/models/widgets/ken_tree_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:ken/smeup/widgets/ken_widget_state_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_state_mixin.dart';

// ignore: must_be_immutable
class KenTree extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
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

  KenTree.withController(
      KenTreeModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenTree(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'TRE',
    this.title = '',
    this.data,
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
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    if (data == null) {
      data = List<dynamic>.empty(growable: true);
    }
  }

  @override
  runControllerActivities(KenModel model) {
    KenTreeModel m = model as KenTreeModel;
    id = m.id;
    type = m.type;
    title = m.title;
    width = m.width;
    height = m.height;
    labelFontSize = m.labelFontSize;
    labelBackColor = m.labelBackColor;
    labelFontColor = m.labelFontColor;
    labelFontbold = m.labelFontbold;
    labelVerticalSpacing = m.labelVerticalSpacing;
    parentFontSize = m.parentFontSize;
    parentBackColor = m.parentBackColor;
    parentFontColor = m.parentFontColor;
    parentFontbold = m.parentFontbold;
    parentVerticalSpacing = m.parentVerticalSpacing;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenTreeModel m = model as KenTreeModel;
  }

  @override
  _KenTreeState createState() => _KenTreeState();
}

class _KenTreeState extends State<KenTree>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenTreeModel? _model;

  @override
  void initState() {
    _model = widget.model;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, widget.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget tree = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
          setState(() {
            widgetLoadType = LoadType.Immediate;
            setDataLoad(widget.id, false);
          });
        });

    return tree;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    Widget? children;

    double? treeHeight = widget.height;
    double? treeWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (treeHeight == 0)
        treeHeight = (_model!.parent as KenSectionModel).height;
      if (treeWidth == 0)
        treeWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (treeHeight == 0)
        treeHeight = KenUtilities
            .getDeviceInfo()
            .safeHeight;
      if (treeWidth == 0) treeWidth = KenUtilities
          .getDeviceInfo()
          .safeWidth;
    }

    return KenWidgetBuilderResponse(_model, children);
  }

}
