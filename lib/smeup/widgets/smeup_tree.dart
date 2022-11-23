import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/models/widgets/smeup_tree_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupTree extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTreeModel? model;
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

  SmeupTree.withController(
      SmeupTreeModel this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupTree(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'TRE',
    this.title = '',
    this.data,
    this.onClientClick,
    this.width = SmeupTreeModel.defaultWidth,
    this.height = SmeupTreeModel.defaultHeight,
    this.labelFontSize = SmeupTreeModel.defaultLabelFontSize,
    this.labelBackColor = SmeupTreeModel.defaultLabelBackColor,
    this.labelFontColor = SmeupTreeModel.defaultLabelFontColor,
    this.labelFontbold = SmeupTreeModel.defaultLabelFontbold,
    this.labelVerticalSpacing = SmeupTreeModel.defaultLabelVerticalSpacing,
    this.labelHeight = SmeupTreeModel.defaultLabelHeight,
    this.parentFontSize = SmeupTreeModel.defaultParentFontSize,
    this.parentBackColor = SmeupTreeModel.defaultParentBackColor,
    this.parentFontColor = SmeupTreeModel.defaultParentFontColor,
    this.parentFontbold = SmeupTreeModel.defaultParentFontbold,
    this.parentVerticalSpacing = SmeupTreeModel.defaultParentVerticalSpacing,
    this.parentHeight = SmeupTreeModel.defaultParentHeight,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    if (data == null) {
      data = List<dynamic>.empty(growable: true);
    }
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTreeModel m = model as SmeupTreeModel;
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
  dynamic treatData(SmeupModel model) {
    SmeupTreeModel m = model as SmeupTreeModel;

    // change data format
    // ignore: unused_local_variable
    var workData = formatDataFields(m);

    // set the widget data
    // if (workData != null) {
    //   var newList = List<String>.empty(growable: true);
    //   for (var i = 0; i < (workData['rows'] as List).length; i++) {
    //     final element = workData['rows'][i];
    //     newList.add(element[m.valueColName].toString());
    //   }
    //   return newList;
    // } else {
    //   return model.data;
    // }
  }

  @override
  _SmeupTreeState createState() => _SmeupTreeState();
}

class _SmeupTreeState extends State<SmeupTree>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupTreeModel? _model;
  // List<dynamic> _data;

  // TreeViewTheme _treeViewTheme = TreeViewTheme(
  //   expanderTheme: ExpanderThemeData(
  //     type: ExpanderType.caret,
  //     modifier: ExpanderModifier.none,
  //     position: ExpanderPosition.start,
  //     color: Colors.red.shade800,
  //     size: 20,
  //   ),
  //   labelStyle: TextStyle(
  //     fontSize: 16,
  //     letterSpacing: 0.3,
  //   ),
  //   parentLabelStyle: TextStyle(
  //     fontSize: 16,
  //     letterSpacing: 0.1,
  //     fontWeight: FontWeight.w800,
  //     color: Colors.red.shade600,
  //   ),
  //   iconTheme: IconThemeData(
  //     size: 18,
  //     color: Colors.grey.shade800,
  //   ),
  //   colorScheme: ColorScheme.dark(),
  // );

  @override
  void initState() {
    _model = widget.model;
    //_data = widget.data;
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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    Widget? children;

    double? treeHeight = widget.height;
    double? treeWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (treeHeight == 0)
        treeHeight = (_model!.parent as SmeupSectionModel).height;
      if (treeWidth == 0)
        treeWidth = (_model!.parent as SmeupSectionModel).width;
    } else {
      if (treeHeight == 0)
        treeHeight = SmeupUtilities.getDeviceInfo().safeHeight;
      if (treeWidth == 0) treeWidth = SmeupUtilities.getDeviceInfo().safeWidth;
    }

    // TreeViewController _treeViewController =
    //     TreeViewController(children: _data);
    // children = Container(
    //     width: treeWidth,
    //     height: treeHeight,
    //     //color: Colors.red,
    //     child: TreeView(
    //       controller: _treeViewController,
    //       allowParentSelect: true,
    //       supportParentDoubleTap: false,
    //       //onExpansionChanged: _expandNodeHandler,
    //       onNodeTap: (key) {
    //         Node selectedNode = _treeViewController.getNode(key);
    //         SmeupDynamismService.storeDynamicVariables(
    //             selectedNode.data, widget.formKey);
    //         if (_model != null)
    //           SmeupDynamismService.run(_model.dynamisms, context, 'click',
    //               widget.scaffoldKey, widget.formKey);
    //         if (widget.onClientClick != null)
    //           widget.onClientClick(selectedNode);
    //       },
    //       theme: TreeViewTheme().copyWith(
    //           iconTheme: IconThemeData().copyWith(size: widget.parentFontSize),
    //           labelStyle: TextStyle(
    //               fontSize: widget.labelFontSize,
    //               color: widget.labelFontColor,
    //               backgroundColor: widget.labelBackColor,
    //               fontWeight: widget.labelFontbold
    //                   ? FontWeight.bold
    //                   : FontWeight.normal),
    //           parentLabelStyle: TextStyle(
    //               fontSize: widget.parentFontSize,
    //               color: widget.parentFontColor,
    //               backgroundColor: widget.parentBackColor,
    //               fontWeight: widget.parentFontbold
    //                   ? FontWeight.bold
    //                   : FontWeight.normal),
    //           labelOverflow: TextOverflow.fade,
    //           parentLabelOverflow: TextOverflow.fade,
    //           verticalSpacing: widget.parentVerticalSpacing),
    //     ));

    //return SmeupWidgetBuilderResponse(smeupTreeModel, Container());
    return SmeupWidgetBuilderResponse(_model, children);
  }

  // dynamic _expandNodeHandler(String text, bool exe) {
  //
  // }
}
