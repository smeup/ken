import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import 'package:flutter_treeview/flutter_treeview.dart';

import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';

class KenTree extends StatefulWidget {
  final List<Node> data;
  final String? title;
  final String? id;
  final String? type;
  final double? width;
  final double? height;
  final double? labelFontSize;
  final Color? labelBackColor;
  final Color? labelFontColor;
  final bool? labelFontbold;
  final double? labelVerticalSpacing;
  final double? labelHeight;
  final double? parentFontSize;
  final Color? parentBackColor;
  final Color? parentFontColor;
  final bool? parentFontbold;
  final double? parentVerticalSpacing;
  final double? parentHeight;
  final bool? expanded;
  final FontWeight? defaultParentFontweight;
  final GlobalKey<ScaffoldState>? scaffoldKey;

  const KenTree({
    super.key,
    this.id = '',
    this.type = 'TRE',
    this.title = '',
    this.data = const [],
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
    this.expanded = KenTreeDefaults.defaultExpanded,
    this.defaultParentFontweight = KenTreeDefaults.defaultParentFontweight,
    this.scaffoldKey,
  });

  @override
  State<KenTree> createState() => _KenTreeState();
}

class _KenTreeState extends State<KenTree> {
  double? parentWidth;
  late List<Node> _data;
  late String _selectedNode;

  late TreeViewController _treeViewController;
  bool docsOpen = true;

  final Map<ExpanderPosition, Widget> expansionPositionOptions = const {
    ExpanderPosition.start: Text('Start'),
    ExpanderPosition.end: Text('End'),
  };

  final Map<ExpanderType, Widget> expansionTypeOptions = {
    ExpanderType.none: Container(),
    ExpanderType.caret: const Icon(
      Icons.arrow_drop_down,
      size: 28,
    ),
    ExpanderType.arrow: const Icon(Icons.arrow_downward),
    ExpanderType.chevron: const Icon(Icons.expand_more),
    ExpanderType.plusMinus: const Icon(Icons.add),
  };

  final Map<ExpanderModifier, Widget> expansionModifierOptions = const {
    ExpanderModifier.none: ModContainer(ExpanderModifier.none),
    ExpanderModifier.circleFilled: ModContainer(ExpanderModifier.circleFilled),
    ExpanderModifier.circleOutlined:
        ModContainer(ExpanderModifier.circleOutlined),
    ExpanderModifier.squareFilled: ModContainer(ExpanderModifier.squareFilled),
    ExpanderModifier.squareOutlined:
        ModContainer(ExpanderModifier.squareOutlined),
  };
  final ExpanderPosition _expanderPosition = ExpanderPosition.start;
  final ExpanderType _expanderType = ExpanderType.chevron;
  final ExpanderModifier _expanderModifier = ExpanderModifier.none;
  final bool _allowParentSelect = false;
  final bool _supportParentDoubleTap = false;

  @override
  void initState() {
    _data = widget.data;
    _treeViewController = TreeViewController(
      children: _data,
      //selectedKey: _selectedNode ?? '',
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var treeView = SizedBox(
      width: widget.width,
      height: widget.height,
      child: TreeView(
        controller: _treeViewController,
        allowParentSelect: _allowParentSelect,
        supportParentDoubleTap: _supportParentDoubleTap,
        onExpansionChanged: (key, expanded) => _expandNode(key, expanded),
        onNodeTap: (key) {
          debugPrint('Selected: $key');
          setState(() {
            _selectedNode = key;

            _treeViewController =
                _treeViewController.copyWith(selectedKey: key);
            KenMessageBus.instance.fireEvent(
              TreeNodeOnTapEvent(
                messageBusId: KenUtilities.getMessageBusId(
                    widget.id!, widget.scaffoldKey),
                data: _treeViewController.getNode(_selectedNode)!.data,
              ),
            );
          });
        },
        theme: _getTreeViewTheme(),
      ),
    );

    return treeView;
  }

  _getTreeViewTheme() {
    return TreeViewTheme(
      expanderTheme: ExpanderThemeData(
          type: _expanderType,
          modifier: _expanderModifier,
          position: _expanderPosition,
          size: 20,
          color: widget.parentFontColor),
      labelStyle: TextStyle(
          fontSize: widget.labelFontSize,
          letterSpacing: 0.3,
          decorationColor: const Color.fromARGB(255, 54, 244, 114),
          color: widget.labelFontColor),
      parentLabelStyle: TextStyle(
        fontSize: widget.parentFontSize,
        letterSpacing: 0.1,
        fontWeight: widget.defaultParentFontweight,
        color: widget.parentFontColor,
      ),
      iconTheme: const IconThemeData(
        size: 18,
        color: kPrimary, // low level icon
        fill: 1,
        opacity: 1,
      ),
      colorScheme: const ColorScheme.light(
          primary: kBack100, onPrimary: kInactivePrimary, outline: kPrimary),
    );
  }

  _expandNode(String key, bool expanded) {
    String msg = '${expanded ? "Expanded" : "Collapsed"}: $key';
    debugPrint(msg);
    Node node = _treeViewController.getNode(key)!;

    List<Node> updated;
    if (key == 'docs') {
      updated = _treeViewController.updateNode(
          key,
          node.copyWith(
            expanded: expanded,
            iconColor: Colors.amber,
            icon: expanded ? Icons.folder_open : Icons.folder,
          ));
    } else {
      updated = _treeViewController.updateNode(key,
          node.copyWith(expanded: expanded, iconColor: widget.labelFontColor));
    }
    setState(() {
      if (key == 'docs') docsOpen = expanded;
      _treeViewController = _treeViewController.copyWith(children: updated);
    });
  }
}

class ModContainer extends StatelessWidget {
  final ExpanderModifier modifier;

  const ModContainer(this.modifier, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double borderWidth = 0;
    BoxShape shapeBorder = BoxShape.rectangle;
    Color backColor = Colors.transparent;
    Color backAltColor = Colors.grey.shade700;
    switch (modifier) {
      case ExpanderModifier.none:
        break;
      case ExpanderModifier.circleFilled:
        shapeBorder = BoxShape.circle;
        backColor = backAltColor;
        break;
      case ExpanderModifier.circleOutlined:
        borderWidth = 1;
        shapeBorder = BoxShape.circle;
        break;
      case ExpanderModifier.squareFilled:
        backColor = backAltColor;
        break;
      case ExpanderModifier.squareOutlined:
        borderWidth = 1;
        break;
    }
    return Container(
      decoration: BoxDecoration(
        shape: shapeBorder,
        border: borderWidth == 0
            ? null
            : Border.all(
                width: borderWidth,
                color: backAltColor,
              ),
        color: backColor,
      ),
      width: 15,
      height: 15,
    );
  }
}
