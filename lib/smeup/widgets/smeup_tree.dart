import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_tree_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupTree extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupTreeModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  List<Node> data;
  String title;
  String id;
  String type;
  Function onClientClick;
  double width;
  double height;

  SmeupTree.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
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
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupTreeModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    width = m.width;
    height = m.height;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupTreeModel m = model;

    // change data format
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
  SmeupTreeModel _model;
  List<Node> _data;

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
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
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

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    Widget children;

    TreeViewController _treeViewController =
        TreeViewController(children: _data);
    children = Container(
        width: widget.width,
        height: widget.height,
        //color: Colors.red,
        child: TreeView(
          controller: _treeViewController,
          allowParentSelect: true,
          supportParentDoubleTap: false,
          //onExpansionChanged: _expandNodeHandler,
          onNodeTap: (key) {
            // var node = (smeupTreeModel.data['rows'] as List<Node>)
            //     .firstWhere((element) => element.key == key);
            Node selectedNode = _treeViewController.getNode(key);
            SmeupDynamismService.storeDynamicVariables(
                selectedNode.data, widget.formKey);
            if (_model != null)
              SmeupDynamismService.run(_model.dynamisms, context, 'click',
                  widget.scaffoldKey, widget.formKey);
            if (widget.onClientClick != null) widget.onClientClick();

            // setState(() {
            //   _treeViewController =
            //       _treeViewController.copyWith(selectedKey: key);
            // });
          },
          theme: TreeViewTheme().copyWith(
              // labelStyle:
              //     TextStyle(color: Colors.yellow, backgroundColor: Colors.red),
              verticalSpacing: 2),
        ));

    //return SmeupWidgetBuilderResponse(smeupTreeModel, Container());
    return SmeupWidgetBuilderResponse(_model, children);
  }

  // dynamic _expandNodeHandler(String text, bool exe) {
  //
  // }
}
