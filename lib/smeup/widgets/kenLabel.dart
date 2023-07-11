import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_label_model.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_section_model.dart';
import '../services/ken_log_service.dart';
import '../services/ken_utilities.dart';
import 'kenNotAvailable.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenLabel extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenLabelModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  // graphic properties
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  Color? backColor;
  double? iconSize;
  Color? iconColor;

  EdgeInsetsGeometry? padding;
  Alignment? align;
  double? width;
  double? height;
  List<String?>? data;
  String? valueColName;
  String? backColorColName;
  String? fontColorColName;
  dynamic iconCode;
  String? title;
  String? id;
  String? type;
  IconData? iconData;

  KenLabel.withController(
      KenLabelModel this.model, this.scaffoldKey, this.formKey, this.iconData)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenLabel(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'LAB',
      this.fontSize,
      this.fontBold,
      this.fontColor,
      this.backColor,
      this.iconData,
      this.iconSize,
      this.iconColor,
      this.valueColName = KenLabelModel.defaultValColName,
      this.padding = KenLabelModel.defaultPadding,
      this.align = KenLabelModel.defaultAlign,
      this.width = KenLabelModel.defaultWidth,
      this.height = KenLabelModel.defaultHeight,
      this.backColorColName = '',
      this.iconCode,
      this.fontColorColName = '',
      this.title = ''})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenLabelModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenLabelModel m = model as KenLabelModel;
    id = m.id;
    type = m.type;
    valueColName = m.valueColName;
    padding = m.padding;
    fontSize = m.fontSize;
    align = m.align;
    fontBold = m.fontBold;
    width = m.width;
    height = m.height;
    backColorColName = m.backColorColName;
    backColor = m.backColor;
    fontColor = m.fontColor;
    iconCode = m.iconCode;
    //iconColname = m.iconColname;
    fontColorColName = m.fontColorColName;
    iconSize = m.iconSize;
    iconColor = m.iconColor;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenLabelModel m = model as KenLabelModel;

    // change data format
    var workData = formatDataFields(model);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);

      // overrides model properties from data
      var firstElement = (workData['rows'] as List).first;
      if (firstElement != null) {
        if (firstElement[m.optionsDefault!['iconColName']] != null) {
          m.iconCode = firstElement[m.optionsDefault!['iconColName']];
        }

        if (firstElement[m.optionsDefault!['backColorColName']] != null) {
          m.backColor = KenUtilities.getColorFromRGB(
              firstElement[m.optionsDefault!['backColorColName']]);
        }

        if (firstElement[m.optionsDefault!['fontColorColName']] != null) {
          m.fontColor = KenUtilities.getColorFromRGB(
              firstElement[m.optionsDefault!['fontColorColName']]);
        }
      }

      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(element[m.valueColName].toString());
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _KenLabelState createState() => _KenLabelState();
}

class _KenLabelState extends State<KenLabel>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenLabelModel? _model;
  dynamic _data;

  @override
  void initState() {
    _model = widget.model;
    _data = widget.data;
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
    Widget label = runBuild(context, widget.id, widget.type, widget.scaffoldKey,
        getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return label;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await _model!.getData();
        // await SmeupLabelDao.getData(_model!);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    List<Align> alignes = List<Align>.empty(growable: true);

    _data.forEach((text) {
      final align = Align(
        alignment: widget.align!,
        child: Text(
          text,
          style: _getTextStile(),
        ),
      );
      alignes.add(align);
    });

    final col = Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: alignes);

    if (alignes.length > 0) {
      double labelHeight =
          widget.height! * alignes.length * (widget.fontSize! / 5);

      double? labelWidth = widget.width;
      if (labelWidth == 0) {
        if (_model != null && _model!.parent != null) {
          labelWidth = (_model!.parent as KenSectionModel).width;
        } else {
          labelWidth = KenUtilities.getDeviceInfo().safeWidth;
        }
      }

      if (widget.iconCode == null) {
        return KenWidgetBuilderResponse(
            _model,
            Container(
                padding: widget.padding,
                //color: widget.backColor,
                height: labelHeight,
                width: labelWidth,
                child: col));
      } else {
        final label = Container(
            //color: widget.backColor,
            height: labelHeight,
            child: col);

        IconThemeData iconTheme = _getIconTheme();

        final icon = Icon(
          widget.iconData,
          //SmeupIconService.getIconData(widget.iconCode),
          color: iconTheme.color,
          size: iconTheme.size,
        );

        var children;
        double widgetHeight = labelHeight + iconTheme.size!;

        if (widget.align == Alignment.centerLeft) {
          children = Container(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label,
                Padding(padding: EdgeInsets.fromLTRB(5, 0, 0, 0)),
                Container(
                  padding: EdgeInsets.fromLTRB(0, 3, 0, 0),
                  constraints: BoxConstraints(
                      maxHeight: 60,
                      minWidth: 0,
                      maxWidth: double.infinity,
                      minHeight: 60),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Align(
                          child: icon,
                        )
                      ]),
                ),
              ],
            ),
            //color: widget.backColor,
          );
        }
        // else if (widget.align == Alignment.centerRight) {
        //   children = Container(
        //     padding: widget.padding,
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         icon,
        //         Padding(padding: EdgeInsets.fromLTRB(0, 20, 10, 0)),
        //         label,
        //       ],
        //     ),
        //     //color: widget.backColor,
        //   );
        // }
        else if (widget.align == Alignment.centerRight) {
          children = Container(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0, 3, 0, 0), child: icon),
                Padding(padding: EdgeInsets.fromLTRB(0, 0, 5, 0)),
                label,
              ],
            ),
            //color: widget.backColor,
          );
        } else if (widget.align == Alignment.topCenter) {
          children = Container(
            padding: widget.padding,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label,
                icon,
              ],
            ),
            //color: widget.backColor,
          );
        } else if (widget.align == Alignment.bottomCenter) {
          children = Container(
            padding: widget.padding,
            height: widgetHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(child: icon),
                label,
              ],
            ),
            //color: widget.backColor,
          );
        } else // center
        {
          children = Container(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                label,
                icon,
              ],
            ),
            //color: widget.backColor,
          );
        }

        return KenWidgetBuilderResponse(_model, children);
      }
    }

    KenLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: KenLogType.error);

    return KenWidgetBuilderResponse(_model, KenNotAvailable());
  }

  TextStyle _getTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.bodyText2!;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

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
