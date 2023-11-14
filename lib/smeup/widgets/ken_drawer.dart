import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../models/widgets/ken_drawer_data_element.dart';
import '../services/ken_defaults.dart';
import 'ken_drawer_item.dart';

class KenDrawer extends StatefulWidget {
  final GlobalKey<ScaffoldState> formKey;

  final double? titleFontSize;
  final Color? titleFontColor;
  final bool? titleFontBold;
  final double? elementFontSize;
  final Color? elementFontColor;
  final bool? elementFontBold;
  final Color? appBarBackColor;
  final bool? showItemDivider;
  final double? imageWidth;
  final double? imageHeight;
  final String? imageUrl;
  final String? title;
  final String? id;
  final String? type;
  final Color? iconColor;
  final double? iconSize;
  final Color? drawerBackColor;
  final List<KenDrawerDataElement>? data;

  const KenDrawer(this.formKey,
      {super.key,
      this.id = '',
      this.type = 'DRW',
      this.appBarBackColor = KenDrawerDefaults.defaultAppBarBackColor,
      this.titleFontSize = KenDrawerDefaults.defaultTitleFontSize,
      this.titleFontColor = KenDrawerDefaults.defaultTitleFontColor,
      this.titleFontBold = KenDrawerDefaults.defaultTitleFontBold,
      this.elementFontSize = KenDrawerDefaults.defaultElementFontSize,
      this.elementFontColor = KenDrawerDefaults.defaultTitleFontColor,
      this.elementFontBold = KenDrawerDefaults.defaultElementFontBold,
      this.iconColor = KenDrawerDefaults.defaultIconColor,
      this.iconSize = KenDrawerDefaults.defaultIconSize,
      this.drawerBackColor = KenDrawerDefaults.defaultDrawerBackColor,
      this.title = '',
      this.imageUrl = '',
      this.data,
      this.imageWidth = KenDrawerDefaults.defaultImageWidth,
      this.imageHeight = KenDrawerDefaults.defaultImageHeight,
      this.showItemDivider = KenDrawerDefaults.defaultShowItemDivider});

  @override
  KenDrawerState createState() => KenDrawerState();
}

class KenDrawerState extends State<KenDrawer> {
  List<KenDrawerDataElement>? _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showTitle = widget.title != null;
    final showImage = widget.imageUrl!.isNotEmpty;
    final List<Widget> headers = [];

    if (showImage) {
      headers.add(Image.asset(
        widget.imageUrl!,
        height: widget.imageHeight,
        width: widget.imageWidth,
      ));
    }
    if (showTitle) {
      headers.add(const SizedBox(
        width: 10,
      ));
      headers.add(Text(
        widget.title!,
        style: _getTitleStile(),
      ));
    }

    var header = AppBar(
        backgroundColor: widget.appBarBackColor,
        //elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: headers,
        ));

    var list = List<Widget>.empty(growable: true);
    list.add(header);

    var groups = <String, List<Widget>>{};

    for (KenDrawerDataElement e in _data!) {
      if (e.group.isEmpty) {
        list.add(KenDrawerItem(widget.formKey, e.text, e.route, e.itemIconData,
            e.action, e.align, false,
            fontSize: e.fontSize));
      } else {
        List<Widget>? listInGroup;
        if (groups[e.group] == null) {
          groups[e.group] = List<Widget>.empty(growable: true);
          listInGroup = groups[e.group];
          list.add(ExpandablePanel(
            header: _getCollpsed(e),
            theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: widget.iconColor,
                tapBodyToCollapse: true),
            expanded: Column(
              children: listInGroup!,
            ),
            collapsed: Container(),
            // tapHeaderToExpand: true,
            // hasIcon: true,
          ));
        }
        listInGroup = groups[e.group];
        listInGroup!.add(Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: KenDrawerItem(widget.formKey, e.text, e.route, e.itemIconData,
              e.action, e.align, widget.showItemDivider,
              fontSize: e.fontSize),
          // SmeupDrawerItem(widget.formKey, widget.sectionKey, e.text,
          //     e.route, e.iconCode, e.action, e.align, widget.showItemDivider,
          //     fontSize: e.fontSize),
        ));
      }
    }

    return Drawer(
        backgroundColor: widget.drawerBackColor,
        child: Container(
          color: widget.appBarBackColor,
          child: Column(
            children: list,
          ),
        ));
  }

  TextStyle _getTitleStile() {
    TextStyle style =
        TextStyle(color: widget.titleFontColor, fontSize: widget.titleFontSize);

    if (widget.titleFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  Widget _getCollpsed(e) {
    return ListTile(
      leading: e.groupIcon != null
          ? Icon(
              e.groupIconData,
              color: widget.iconColor,
              size: widget.iconSize,
            )
          : null,
      title: Text(e.group, style: _getElementTextStile()),
    );
  }

  TextStyle _getElementTextStile() {
    TextStyle style = const TextStyle(backgroundColor: Colors.transparent);

    if (widget.elementFontSize != null) {
      style = style.copyWith(
        fontSize: widget.elementFontSize,
      );
    }

    if (widget.elementFontColor != null) {
      style = style.copyWith(
        color: widget.elementFontColor,
      );
    }

    if (widget.elementFontBold != null && widget.elementFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
