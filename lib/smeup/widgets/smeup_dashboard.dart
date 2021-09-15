import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_dashboard_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_dashboard_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupDashboard extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupDashboardModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  double data;
  String unitOfMeasure = '';
  String text = '';
  int icon = 0;

  String valueColName;
  Color iconColor;
  String selectLayout;
  double fontsize;
  double labelFontsize;
  double width;
  double height;
  double iconSize;
  EdgeInsetsGeometry padding;
  String title;
  String id;
  String type;

  SmeupDashboard(this.scaffoldKey, this.formKey, this.data,
      {id = '',
      type = 'DSH',
      this.valueColName = SmeupDashboardModel.defaultValueColName,
      this.text = '',
      this.unitOfMeasure = '',
      this.icon,
      this.iconColor,
      this.selectLayout = SmeupDashboardModel.defaultSelectLayout,
      this.width = SmeupDashboardModel.defaultWidth,
      this.height = SmeupDashboardModel.defaultHeight,
      this.fontsize = SmeupDashboardModel.defaultFontsize,
      this.labelFontsize = SmeupDashboardModel.defaultLabelFontsize,
      this.iconSize = SmeupDashboardModel.defaultIconSize,
      this.padding = SmeupDashboardModel.defaultPadding,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
  }

  SmeupDashboard.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupDashboardModel m = model;
    id = m.id;
    type = m.type;
    valueColName = m.valueColName;
    iconColor = m.iconColor;
    unitOfMeasure = m.selectLayout = m.selectLayout;
    fontsize = m.fontsize;
    labelFontsize = m.labelFontsize;
    width = m.width;
    height = m.height;
    iconSize = m.iconSize;
    padding = m.padding;
    title = m.title;

    dynamic workData = treatData(m);

    // set the widget data
    if (workData != null &&
        (workData['rows'] as List).length > 0 &&
        workData['rows'][0][m.valueColName] != null) {
      data = workData['rows'][0][m.valueColName];
      unitOfMeasure = workData['rows'][0]['um'];
      text = workData['rows'][0]['description'];
      icon = workData['rows'][0]['icon'];
    }
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupDashboardModel m = model;

    // change data format
    return formatDataFields(m);
  }

  @override
  _SmeupDashboardState createState() => _SmeupDashboardState();
}

class _SmeupDashboardState extends State<SmeupDashboard>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupDashboardModel _model;
  double _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final dashboard = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return dashboard;
  }

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupDashboardDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    Widget children;

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    if (widget.valueColName.isEmpty) {
      SmeupLogService.writeDebugMessage(
          'Error SmeupDashboard ValColName not set',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    children = Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            if (widget.icon != null && widget.icon != 0)
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: Icon(
                    IconData(widget.icon, fontFamily: 'MaterialIcons'),
                    color: widget.iconColor,
                    size: widget.iconSize,
                  )),
            Text(
              _data.toString(),
              style: TextStyle(fontSize: widget.fontsize),
            )
          ]),
          Text(
            widget.text,
            style: TextStyle(fontSize: widget.labelFontsize),
          )
        ],
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }
}
