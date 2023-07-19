import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_drawer_data_element.dart';
import '../models/widgets/ken_drawer_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_utilities.dart';
import 'kenDrawerItem.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenDrawer extends StatefulWidget
// with SmeupWidgetMixin
// implements SmeupWidgetInterface//todo da togliere
{
  KenDrawerModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  double? titleFontSize;
  Color? titleFontColor;
  bool? titleFontBold;
  double? elementFontSize;
  Color? elementFontColor;
  bool? elementFontBold;
  Color? appBarBackColor;
  bool? showItemDivider;
  double? imageWidth;
  double? imageHeight;
  String? imageUrl;
  String? title;
  String? id;
  String? type;
  List<KenDrawerDataElement>? drawerDataElement;

  KenDrawer(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'DRW',
      this.appBarBackColor,
      this.titleFontSize,
      this.titleFontColor,
      this.titleFontBold,
      this.elementFontSize,
      this.elementFontColor,
      this.elementFontBold,
      this.title = '',
      this.imageUrl = '',
      this.drawerDataElement,
      //this.data,
      this.imageWidth = KenDrawerModel.defaultImageWidth,
      this.imageHeight = KenDrawerModel.defaultImageHeight,
      this.showItemDivider = KenDrawerModel.defaultShowItemDivider})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenDrawerModel.setDefaults(this);
  }

  KenDrawer.withController(
    KenDrawerModel this.model,
    this.scaffoldKey,
    this.formKey,
    this.drawerDataElement,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  //@override ???
  runControllerActivities(KenModel model) {
    KenDrawerModel m = model as KenDrawerModel;
    id = m.id;
    type = m.type;
    title = m.title;
    imageUrl = m.imageUrl;
    imageWidth = m.imageWidth;
    imageHeight = m.imageHeight;
    appBarBackColor = m.appBarBackColor;
    titleFontSize = m.titleFontSize;
    titleFontBold = m.titleFontBold;
    titleFontColor = m.titleFontColor;
    elementFontSize = m.elementFontSize;
    elementFontBold = m.elementFontBold;
    elementFontColor = m.elementFontColor;
    showItemDivider = m.showItemDivider;
  }

  @override
  _KenDrawerState createState() => _KenDrawerState();
}

class _KenDrawerState extends State<KenDrawer>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenDrawerModel? _model;
  List<KenDrawerDataElement>? _data;

  @override
  void initState() {
    _model = widget.model;
    // _data = widget.data;
    _data = widget.drawerDataElement;
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
    var drawer = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });
    return drawer;
  }

  Widget _getCollpsed(e) {
    return ListTile(
      leading: e.groupIcon != null
          ? Icon(
              e.groupIconData,
              color: _getIconTheme().color,
              size: _getIconTheme().size,
            )
          : null,
      title: Text(e.group, style: _getElementTextStile()),
    );
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      _data = widget.drawerDataElement;

      setDataLoad(widget.id, true);
    }

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
        backgroundColor: _getAppBarTheme().backgroundColor,
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
        list.add(KenDrawerItem(widget.scaffoldKey, widget.formKey, e.text,
            e.route, e.itemIconData, e.action, e.align, false,
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
                iconColor: _getIconTheme().color,
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
          child: KenDrawerItem(
              widget.scaffoldKey,
              widget.formKey,
              e.text,
              e.route,
              e.itemIconData,
              e.action,
              e.align,
              widget.showItemDivider,
              fontSize: e.fontSize),
          // SmeupDrawerItem(widget.scaffoldKey, widget.formKey, e.text,
          //     e.route, e.iconCode, e.action, e.align, widget.showItemDivider,
          //     fontSize: e.fontSize),
        ));
      }
    }

    return KenWidgetBuilderResponse(
      _model,
      Drawer(
          child: Container(
        color: _getAppBarTheme().backgroundColor,
        child: Column(
          children: list,
        ),
      )),
    );
  }

  AppBarTheme _getAppBarTheme() {
    return KenConfigurationService.getTheme()!
        .appBarTheme
        .copyWith(backgroundColor: widget.appBarBackColor);
  }

  TextStyle _getTitleStile() {
    TextStyle style = _getAppBarTheme().titleTextStyle!;

    style = style.copyWith(
        color: widget.titleFontColor, fontSize: widget.titleFontSize);

    if (widget.titleFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getElementTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!
        .appBarTheme
        .toolbarTextStyle!
        .copyWith(
            backgroundColor: KenConfigurationService.getTheme()!
                .appBarTheme
                .backgroundColor);

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

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!.iconTheme;

    return themeData;
  }
}
