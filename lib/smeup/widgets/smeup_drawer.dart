import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_drawer_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_drawer_data_element.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_drawer_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_drawer_item.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupDrawer extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupDrawerModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  double imageWidth;
  double imageHeight;
  String imageUrl;
  Color navbarBackcolor;
  String title;
  String id;
  String type;
  List<SmeupDrawerDataElement> data;

  SmeupDrawer(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'DWR',
      this.title = '',
      this.imageUrl = '',
      this.data,
      this.imageWidth = SmeupDrawerModel.defaultImageWidth,
      this.imageHeight = SmeupDrawerModel.defaultImageHeight,
      this.navbarBackcolor})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
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
    imageWidth = m.imageWidth;
    imageHeight = m.imageHeight;
    navbarBackcolor = m.navbarBackcolor;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupDrawerModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<SmeupDrawerDataElement>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(SmeupDrawerDataElement(element['text'], element['route'],
            iconCode: element['iconCode'],
            fontSize: element['fontSize'],
            align: SmeupUtilities.getAlignmentGeometry(element['align']),
            action: element['action'],
            group: element['group'],
            groupFontSize: element['groupFontSize'],
            groupIcon: element['groupIcon']));
      }
      return newList;
    } else {
      return model.data;
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
      headers.add(Text(widget.title));
    }

    var header = AppBar(
        backgroundColor: widget.navbarBackcolor,
        elevation: 0,
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
            e.text, e.route, e.iconCode, e.action, e.fontSize, e.align));
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
                      color: SmeupConfigurationService.getTheme().primaryColor,
                    )
                  : null,
              title: Text(e.group, style: TextStyle(fontSize: e.groupFontSize)),
            ),
            theme: const ExpandableThemeData(
                headerAlignment: ExpandablePanelHeaderAlignment.center,
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
          child: SmeupDrawerItem(
              e.text, e.route, e.iconCode, e.action, e.fontSize, e.align),
        ));
      }
    }

    return SmeupWidgetBuilderResponse(
        _model,
        Drawer(
            child: Column(
          children: list,
        )));
  }
}
