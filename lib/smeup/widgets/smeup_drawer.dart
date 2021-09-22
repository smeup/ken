import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_drawer_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_drawer_item.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

class SmeupDrawer extends StatefulWidget {
  final SmeupDrawerModel smeupDrawerModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupDrawer(
    this.smeupDrawerModel,
    this.scaffoldKey,
    this.formKey,
  );

  @override
  _SmeupDrawerState createState() => _SmeupDrawerState();
}

class _SmeupDrawerState extends State<SmeupDrawer> with SmeupWidgetStateMixin {
  dynamic data;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var drawer = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getDrawerComponent(widget.smeupDrawerModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupDrawerModel.showLoader ? SmeupWait() : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupDrawer: ${snapshot.error}',
                logType: LogType.error);
            notifyError(context, widget.smeupDrawerModel.id, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    // SmeupWidgetsNotifier.addWidget(widget.formKey, widget.smeupDrawerModel.id,
    //     widget.smeupDrawerModel.type);
    return drawer;
  }

  Future<SmeupWidgetBuilderResponse> _getDrawerComponent(
      SmeupDrawerModel smeupDrawerModel) async {
    if (smeupDrawerModel.clientData != null) data = smeupDrawerModel.clientData;

    if (hasData(smeupDrawerModel)) {
      data = smeupDrawerModel.data;
    }

    final showTitle = smeupDrawerModel.title != null;
    final showImage = smeupDrawerModel.image != null;
    final List<Widget> headers = [];

    if (showImage)
      headers.add(Image.asset(
        smeupDrawerModel.image,
        height: smeupDrawerModel.imageHeight,
        width: smeupDrawerModel.imageWidth,
      ));
    if (showTitle) {
      headers.add(const SizedBox(
        width: 10,
      ));
      headers.add(Text(smeupDrawerModel.title));
    }

    var header = AppBar(
        backgroundColor: smeupDrawerModel.navbarBackcolor,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: headers,
        ));

    var list = List<Widget>.empty(growable: true);
    list.add(header);

    var groups = Map<String, List<Widget>>();

    for (var e in (data as List)) {
      if (e['align'] == null) {
        e['align'] = Alignment.centerLeft;
      }
      if (e['group'] == null) {
        list.add(SmeupDrawerItem(e['text'], e['route'], e['iconCode'],
            e['action'], e['fontSize'], e['align'], e['pop']));
      } else {
        List<Widget> listInGroup;
        if (groups[e['group']] == null) {
          groups[e['group']] = List<Widget>.empty(growable: true);
          listInGroup = groups[e['group']];
          list.add(ExpandablePanel(
            header: ListTile(
              leading: Icon(
                IconData(e['groupIcon'], fontFamily: 'MaterialIcons'),
                color: SmeupOptions.theme.primaryColor,
              ),
              title: Text(e['group'],
                  style: TextStyle(fontSize: e['groupFontSize'])),
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
        listInGroup = groups[e['group']];
        listInGroup.add(Padding(
          padding: const EdgeInsets.only(left: 60.0),
          child: SmeupDrawerItem(e['text'], e['route'], e['iconCode'],
              e['action'], e['fontSize'], e['align'], e['pop']),
        ));
      }
    }

    return SmeupWidgetBuilderResponse(
        smeupDrawerModel,
        Drawer(
            child: Column(
          children: list,
        )));

    //return SmeupWidgetBuilderResponse(smeupDrawerModel, SmeupNotAvailable());
  }
}
