import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_dashboard_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_log_service.dart';
import '../services/ken_utilities.dart';
import 'kenNotAvailable.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';
import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenDashboard extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenDashboardModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? captionFontSize;
  bool? captionFontBold;
  Color? captionFontColor;
  double? iconSize;
  Color? iconColor;

  double? data;
  String? unitOfMeasure = '';
  String? text = '';
  //dynamic icon;
  String? valueColName;
  String? selectLayout;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? title;
  String? id;
  String? type;
  String? forceText;
  String? forceUm;
  String? forceValue;
  String? forceIcon;
  String? numberFormat;
  IconData? iconData;

  KenDashboard(this.scaffoldKey, this.formKey, this.data,
      {id = '',
      type = 'DSH',
      this.fontColor,
      this.fontSize,
      this.fontBold,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.iconData,
      this.iconSize,
      this.iconColor,
      this.forceIcon,
      this.forceText,
      this.forceUm,
      this.forceValue,
      this.valueColName = KenDashboardModel.defaultValueColName,
      this.text = '',
      this.unitOfMeasure = '',
      //this.icon,
      this.selectLayout = KenDashboardModel.defaultSelectLayout,
      this.width = KenDashboardModel.defaultWidth,
      this.height = KenDashboardModel.defaultHeight,
      this.padding = KenDashboardModel.defaultPadding,
      this.numberFormat = KenDashboardModel.defaultNumberFormat,
      this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenDashboardModel.setDefaults(this);
  }

  KenDashboard.withController(KenDashboardModel this.model, this.scaffoldKey,
      this.formKey, this.iconData)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenDashboardModel m = model as KenDashboardModel;
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
  dynamic treatData(KenModel model) {
    KenDashboardModel m = model as KenDashboardModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null &&
        (workData['rows'] as List).length > 0 &&
        workData['rows'][0][m.valueColName] != null) {
      data = KenUtilities.getDouble(workData['rows'][0][m.valueColName]);
      unitOfMeasure = workData['rows'][0][m.umColName];
      text = workData['rows'][0][m.textColName];
    }

    if (m.forceText!.isNotEmpty) {
      text = m.forceText;
    }

    //???
    // if (m.forceIcon!.isNotEmpty) {
    //   //icon = m.forceIcon;
    // }

    if (m.forceUm!.isNotEmpty) {
      unitOfMeasure = m.forceUm;
    }

    if (m.forceValue!.isNotEmpty) {
      data = m.forceValue as double?;
    }

    return data;
  }

  @override
  _KenDashboardState createState() => _KenDashboardState();
}

class _KenDashboardState extends State<KenDashboard>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenDashboardModel? _model;
  double? _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupDashboardDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    Widget children;

    // if (_data == null) {
    //   return getFunErrorResponse(context, _model);
    // }

    if (widget.valueColName!.isEmpty) {
      KenLogService.writeDebugMessage('Error SmeupDashboard ValColName not set',
          logType: KenLogType.error);
      return KenWidgetBuilderResponse(_model, KenNotAvailable());
    }

    final iconTheme = _getIconTheme();
    final captionStyle = _getCaptionStile();
    final textStyle = _getTextStile();
    final unitOfMeasureStyle = _getUnitOfMeasureStyle();

    children = Container(
        height: widget.height,
        width: widget.width,
        padding: widget.padding,
        alignment: Alignment.center,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Icon(
                      widget.iconData,
                      //SmeupIconService.getIconData(widget.icon),
                      color: iconTheme.color,
                      size: iconTheme.size,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      _getValue(_data),
                      style: textStyle,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Column(
                      children: [
                        Text(
                          widget.unitOfMeasure!,
                          style: unitOfMeasureStyle,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),
                if (widget.text != null)
                  Text(
                    widget.text!,
                    style: captionStyle,
                  )
              ]),
        ));

    // children = Container(
    //   height: widget.height,
    //   width: widget.width,
    //   padding: widget.padding,
    //   alignment: Alignment.center,
    //   child: SingleChildScrollView(
    //     scrollDirection: Axis.horizontal,
    //     child: Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    //           if (widget.iconData != null)
    //             Icon(
    //               widget.iconData,
    //               //SmeupIconService.getIconData(widget.icon),
    //               color: iconTheme.color,
    //               size: iconTheme.size,
    //             ),
    //           Text(
    //             _getValue(_data),
    //             style: textStyle,
    //           ),
    //           Column(
    //             mainAxisAlignment: MainAxisAlignment.start,
    //             children: [
    //               Text(
    //                 widget.unitOfMeasure!,
    //                 textAlign: TextAlign.start,
    //               ),
    //             ],
    //           )
    //         ]),
    //         if (widget.text != null)
    //           Text(
    //             widget.text!,
    //             style: captionStyle,
    //           )
    //       ],
    //     ),
    //   ),
    // );

    return KenWidgetBuilderResponse(_model, children);
  }

  String _getValue(double? data) {
    String newValue = _data.toString();
    try {
      var split = widget.numberFormat!.split(';');
      // String integers = split[0]; not used
      String decimals = split[1];
      int? precision = int.tryParse(decimals);
      switch (precision) {
        case 0:
          newValue = KenUtilities.getInt(data).toString();
          break;
        default:
          newValue = data!.toStringAsFixed(precision!);
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error in dashboard _getValue: $e ',
          logType: KenLogType.error);
    }
    return newValue;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.headline1!;

    style = style.copyWith(
      color: widget.fontColor,
      fontSize: widget.fontSize,
    );

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getUnitOfMeasureStyle() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.headline6!;

    style = style.copyWith(
      color: widget.captionFontColor,
      fontSize: widget.captionFontSize,
    );

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: widget.iconSize, color: widget.iconColor);

    return themeData;
  }
}
