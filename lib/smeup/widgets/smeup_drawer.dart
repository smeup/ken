import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_drawer_dao.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/models/widgets/smeup_drawer_data_element.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/screens/smeup_dynamic_screen.dart';
import 'package:ken/smeup/services/SmeupLocalizationService.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_drawer_model.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/widgets/smeup_drawer_item.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupDrawer extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupDrawerModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  double titleFontSize;
  Color titleFontColor;
  bool titleFontBold;
  double elementFontSize;
  Color elementFontColor;
  bool elementFontBold;
  Color appBarBackColor;
  bool showItemDivider;
  double imageWidth;
  double imageHeight;
  String imageUrl;
  String title;
  String id;
  String type;
  List<SmeupDrawerDataElement> data;

  SmeupDrawer(this.scaffoldKey, this.formKey,
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
      this.data,
      this.imageWidth = SmeupDrawerModel.defaultImageWidth,
      this.imageHeight = SmeupDrawerModel.defaultImageHeight,
      this.showItemDivider = SmeupDrawerModel.defaultShowItemDivider})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupDrawerModel.setDefaults(this);
  }

  SmeupDrawer.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupDrawerModel m = model;
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

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupDrawerModel m = model;

    // change data format
    var workData = formatDataFields(m);
    var newList = List<SmeupDrawerDataElement>.empty(growable: true);

    // set the widget data
    if (workData != null) {
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(SmeupDrawerDataElement(element['text'],
            route: element['route'],
            iconCode: SmeupUtilities.getInt(element['iconCode']) ?? 0,
            fontSize: SmeupUtilities.getDouble(element['fontSize']) ?? 0.0,
            align: SmeupUtilities.getAlignmentGeometry(element['align']) ??
                Alignment.center,
            action: element['route'] == null
                ? null
                : (context) {
                    final smeupFun = SmeupFun(
                        element['route'], formKey, scaffoldKey, context);

                    Navigator.of(context).pushNamed(
                        SmeupDynamicScreen.routeName,
                        arguments: {'isDialog': false, 'smeupFun': smeupFun});
                  },
            group: element['group'] ?? '',
            groupFontSize:
                SmeupUtilities.getDouble(element['groupFontSize']) ?? 0.0,
            groupIcon: SmeupUtilities.getInt(element['groupIcon']) ?? 0));
      }
    }

    SmeupDrawer.addInternalDrawerElements(newList, null);

    return newList;
  }

  static addInternalDrawerElements(newList, BuildContext context) {
    if (SmeupConfigurationService.authenticationModel.managed) {
      newList.addAll([
        SmeupDrawerDataElement(
          'Logout',
          action: (context) async {
            bool loggedOut = await SmeupConfigurationService.authenticationModel
                .logoutFunction();
            if (loggedOut)
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/MainScreen', (Route<dynamic> route) => false);
          },
          iconCode: 58291,
          group: context != null
              ? SmeupLocalizationService.of(context).getLocalString('settings')
              : "SETTINGS",
          fontSize: 15,
          groupIcon: 58751,
          groupFontSize: 20,
        )
      ]);
    }
  }

  @override
  _SmeupDrawerState createState() => _SmeupDrawerState();
}

class _SmeupDrawerState extends State<SmeupDrawer>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupDrawerModel _model;
  List<SmeupDrawerDataElement> _data;

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
    var drawer = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });
    return drawer;
  }

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupDrawerDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    final showTitle = widget.title != null;
    final showImage = widget.imageUrl.isNotEmpty;
    final List<Widget> headers = [];

    if (showImage)
      headers.add(Image.asset(
        widget.imageUrl,
        height: widget.imageHeight,
        width: widget.imageWidth,
      ));
    if (showTitle) {
      headers.add(const SizedBox(
        width: 10,
      ));
      headers.add(Text(
        widget.title,
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

    var groups = Map<String, List<Widget>>();

    for (SmeupDrawerDataElement e in _data) {
      if (e.group.isEmpty) {
        list.add(SmeupDrawerItem(
            e.text, e.route, e.iconCode, e.action, e.align, false,
            fontSize: e.fontSize));
      } else {
        List<Widget> listInGroup;
        if (groups[e.group] == null) {
          groups[e.group] = List<Widget>.empty(growable: true);
          listInGroup = groups[e.group];
          list.add(ExpandablePanel(
            header: ListTile(
              leading: e.groupIcon > 0
                  ? Icon(
                      IconData(e.groupIcon, fontFamily: 'MaterialIcons'),
                      color: _getIconTheme().color,
                      size: _getIconTheme().size,
                    )
                  : null,
              title: Text(e.group, style: _getElementTextStile()),
            ),
            theme: ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
                iconColor: _getIconTheme().color,
                tapBodyToCollapse: true),
            expanded: Column(
              children: listInGroup,
            ),
            // tapHeaderToExpand: true,
            // hasIcon: true,
          ));
        }
        listInGroup = groups[e.group];
        listInGroup.add(Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: SmeupDrawerItem(e.text, e.route, e.iconCode, e.action, e.align,
              widget.showItemDivider,
              fontSize: e.fontSize),
        ));
      }
    }

    return SmeupWidgetBuilderResponse(
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
    return SmeupConfigurationService.getTheme()
        .appBarTheme
        .copyWith(backgroundColor: widget.appBarBackColor);
  }

  TextStyle _getTitleStile() {
    TextStyle style = _getAppBarTheme().titleTextStyle;

    style = style.copyWith(
        color: widget.titleFontColor, fontSize: widget.titleFontSize);

    if (widget.titleFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getElementTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme()
        .appBarTheme
        .toolbarTextStyle
        .copyWith(
            backgroundColor: SmeupConfigurationService.getTheme()
                .appBarTheme
                .backgroundColor);

    if (widget.elementFontSize != null)
      style = style.copyWith(
        fontSize: widget.elementFontSize,
      );

    if (widget.elementFontColor != null)
      style = style.copyWith(
        color: widget.elementFontColor,
      );

    if (widget.elementFontBold != null && widget.elementFontBold)
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme().iconTheme;

    return themeData;
  }
}
