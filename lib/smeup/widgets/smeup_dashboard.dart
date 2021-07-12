import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_dashboard_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/notifiers/smeup_dashboard_notifier.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_wait.dart';
import 'package:provider/provider.dart';
import '../notifiers/smeup_widgets_notifier.dart';

class SmeupDashboard extends StatefulWidget {
  final SmeupDashboardModel smeupDashboardModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupDashboard(this.smeupDashboardModel, this.scaffoldKey, this.formKey);

  @override
  _SmeupDashboardState createState() => _SmeupDashboardState();
}

class _SmeupDashboardState extends State<SmeupDashboard> {
  @override
  void dispose() {
    SmeupWidgetsNotifier.removeWidget(
        widget.scaffoldKey.hashCode, widget.smeupDashboardModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final SmeupDashboardNotifier notifier = Provider.of<SmeupDashboardNotifier>(
        context,
        listen: widget.smeupDashboardModel.notificationEnabled);

    final dash = FutureBuilder<SmeupWidgetBuilderResponse>(
      future: _getDashboardComponent(widget.smeupDashboardModel),
      builder: (BuildContext context,
          AsyncSnapshot<SmeupWidgetBuilderResponse> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return widget.smeupDashboardModel.showLoader
              ? SmeupWait()
              : Container();
        } else {
          if (snapshot.hasError) {
            SmeupLogService.writeDebugMessage(
                'Error SmeupDashboard: ${snapshot.error}',
                logType: LogType.error);
            widget.smeupDashboardModel.notifyError(context, snapshot.error);
            return SmeupNotAvailable();
          } else {
            return snapshot.data.children;
          }
        }
      },
    );

    if (widget.smeupDashboardModel.notificationEnabled) {
      SmeupWidgetsNotifier.addWidget(
          widget.scaffoldKey.hashCode,
          widget.smeupDashboardModel.id,
          widget.smeupDashboardModel.type,
          notifier);
    }

    return dash;
  }

  Future<SmeupWidgetBuilderResponse> _getDashboardComponent(
      SmeupDashboardModel smeupDashboardModel) async {
    Widget children;
    var value;

    await smeupDashboardModel.setData();

    if (!smeupDashboardModel.hasData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${smeupDashboardModel.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(
          smeupDashboardModel, SmeupNotAvailable());
    }

    if (smeupDashboardModel.valueColName.isEmpty) {
      SmeupLogService.writeDebugMessage(
          'Error SmeupDashboard ValColName not set',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(
          smeupDashboardModel, SmeupNotAvailable());
    }

    String fieldName = smeupDashboardModel.valueColName;
    value = smeupDashboardModel.data['rows'][0][fieldName];

    children = Container(
      height: smeupDashboardModel.height,
      width: smeupDashboardModel.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (smeupDashboardModel.forceIcon != 0)
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    IconData(smeupDashboardModel.forceIcon,
                        fontFamily: 'MaterialIcons'),
                    color: smeupDashboardModel.iconColor,
                    size: smeupDashboardModel.iconSize,
                  )),
            Text(
              value,
              style: TextStyle(fontSize: smeupDashboardModel.fontsize),
            )
          ]),
          Text(
            smeupDashboardModel.forceText,
            style: TextStyle(fontSize: smeupDashboardModel.labelFontsize),
          )
        ],
      ),
    );

    return SmeupWidgetBuilderResponse(smeupDashboardModel, children);
  }
}
