import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_tree_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_tree_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';
import '../notifiers/smeup_widgets_notifier.dart';

class SmeupTree extends StatefulWidget {
  final SmeupTreeModel smeupTreeModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupTree(this.smeupTreeModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupTreeState createState() => _SmeupTreeState();
}

class _SmeupTreeState extends State<SmeupTree> {
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
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupTreeModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupTreeNotifier notifier = Provider.of<SmeupTreeNotifier>(context);

    final tree = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getTreeComponent(widget.smeupTreeModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupTreeModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupTree: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupTreeModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    SmeupWidgetsNotifier.addWidget(widget.scaffoldKey.hashCode,
        widget.smeupTreeModel.id, widget.smeupTreeModel.type, notifier);

    return tree;
  }

  Future<SmeupWidgetBuilderResponse> _getTreeComponent(
      SmeupTreeModel smeupTreeModel) async {
    Widget children;

    await smeupTreeModel.setData();

    if (!smeupTreeModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupTreeModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(smeupTreeModel, SmeupNotAvailable());
    }

    TreeViewController _treeViewController = TreeViewController(
        children: (smeupTreeModel.data['rows'] as List<Node>));
    children = Container(
        width: 100,
        height: 200,
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
            SmeupDynamismService.storeDynamicVariables(selectedNode.data);
            SmeupDynamismService.run(
                smeupTreeModel.dynamisms, context, 'click', widget.scaffoldKey);

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
    return SmeupWidgetBuilderResponse(smeupTreeModel, children);
  }

  // dynamic _expandNodeHandler(String text, bool exe) {
  //
  // }
}
