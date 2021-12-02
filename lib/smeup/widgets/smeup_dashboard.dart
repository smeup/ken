import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_dashboard_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_dashboard_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
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

  double fontSize;
  Color fontColor;
  bool fontBold;
  double captionFontSize;
  bool captionFontBold;
  Color captionFontColor;
  double iconSize;
  Color iconColor;

  double data;
  String unitOfMeasure = '';
  String text = '';
  int icon = 0;
  String valueColName;
  String selectLayout;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  String title;
  String id;
  String type;
  String forceText;
  String forceUm;
  String forceValue;
  String forceIcon;
  String numberFormat;

  SmeupDashboard(this.scaffoldKey, this.formKey, this.data,
      {id = '',
      type = 'DSH',
      this.fontColor,
      this.fontSize,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.iconSize,
      this.iconColor,
      this.forceIcon,
      this.forceText,
      this.forceUm,
      this.forceValue,
      this.valueColName = SmeupDashboardModel.defaultValueColName,
      this.text = '',
      this.unitOfMeasure = '',
      this.icon,
      this.selectLayout = SmeupDashboardModel.defaultSelectLayout,
      this.width = SmeupDashboardModel.defaultWidth,
      this.height = SmeupDashboardModel.defaultHeight,
      this.padding = SmeupDashboardModel.defaultPadding,
      this.numberFormat = SmeupDashboardModel.defaultNumberFormat,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupDashboardModel.setDefaults(this);
  }

  SmeupDashboard.withController(this.model, this.scaffoldKey, this.formKey)
      : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupDashboardModel m = model;
    fontSize = m.fontSize;
    fontColor = m.fontColor;
    fontBold = m.fontBold;
    captionFontSize = m.captionFontSize;
    captionFontColor = m.captionFontColor;
    captionFontBold = m.captionFontBold;
    iconColor = m.iconColor;
    iconSize = m.iconSize;
    id = m.id;
    type = m.type;
    valueColName = m.valueColName;
    unitOfMeasure = m.selectLayout = m.selectLayout;
    width = m.width;
    height = m.height;
    padding = m.padding;
    title = m.title;
    forceValue = m.forceValue;
    forceIcon = m.forceIcon;
    forceUm = m.forceUm;
    forceText = m.forceText;
    numberFormat = m.numberFormat;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupDashboardModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null &&
        (workData['rows'] as List).length > 0 &&
        workData['rows'][0][m.valueColName] != null) {
      data = SmeupUtilities.getDouble(workData['rows'][0][m.valueColName]);
      unitOfMeasure = workData['rows'][0][m.umColName];
      text = workData['rows'][0][m.textColName];
      icon = SmeupUtilities.getInt(workData['rows'][0][m.iconColName]);
    }

    if (m.forceText.isNotEmpty) {
      text = m.forceText;
    }

    if (m.forceIcon.isNotEmpty) {
      icon = m.forceIcon as int;
    }

    if (m.forceUm.isNotEmpty) {
      unitOfMeasure = m.forceUm;
    }

    if (m.forceValue.isNotEmpty) {
      data = m.forceValue as double;
    }

    return data;
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

  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupDashboardDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    Widget children;

    // if (_data == null) {
    //   return getFunErrorResponse(context, _model);
    // }

    if (widget.valueColName.isEmpty) {
      SmeupLogService.writeDebugMessage(
          'Error SmeupDashboard ValColName not set',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    final iconTheme = _getIconTheme();
    final captionStyle = _getCaptionStile();
    final textStyle = _getTextStile();

    children = Container(
      height: widget.height,
      width: widget.width,
      padding: widget.padding,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              if (widget.icon != null && widget.icon != 0)
                Icon(
                  IconData(widget.icon, fontFamily: 'MaterialIcons'),
                  color: iconTheme.color,
                  size: iconTheme.size,
                ),
              Text(
                _getValue(_data),
                style: textStyle,
              )
            ]),
            if (widget.text != null)
              Text(
                widget.text,
                style: captionStyle,
              )
          ],
        ),
      ),
    );

    return SmeupWidgetBuilderResponse(_model, children);
  }

  String _getValue(double data) {
    String newValue = _data.toString();
    try {
      var split = widget.numberFormat.split(';');
      // String integers = split[0]; not used
      String decimals = split[1];
      int precision = int.tryParse(decimals);
      switch (precision) {
        case 0:
          newValue = SmeupUtilities.getInt(data).toString();
          break;
        default:
          newValue = data.toStringAsFixed(precision);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in dashboard _getValue: $e ',
          logType: LogType.error);
    }
    return newValue;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.caption;

    style = style.copyWith(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.headline1;

    style = style.copyWith(
      color: widget.fontColor,
      fontSize: widget.fontSize,
    );

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme()
        .iconTheme
        .copyWith(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }
}
