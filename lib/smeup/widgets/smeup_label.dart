import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_label_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
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
class SmeupLabel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupLabelModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  // graphic properties
  double padding;
  double fontSize;
  double iconSize;
  Alignment align;
  bool fontbold;
  double width;
  double height;
  dynamic clientData;
  String valueColName;
  String colorColName;
  String colorFontColName;
  int iconData;
  String iconColname;
  Color backColor;
  Color fontColor;
  String title;
  String id;
  String type;

  SmeupLabel.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupLabel(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'LAB',
      this.valueColName = '',
      this.padding = SmeupLabelModel.defaultPadding,
      this.fontSize = SmeupLabelModel.defaultFontSize,
      this.align = SmeupLabelModel.defaultAlign,
      this.fontbold = SmeupLabelModel.defaultFontbold,
      this.width = SmeupLabelModel.defaultWidth,
      this.height = SmeupLabelModel.defaultHeight,
      this.clientData,
      this.colorColName = '',
      this.backColor,
      this.fontColor,
      this.iconData = 0,
      this.iconColname = '',
      this.colorFontColName = '',
      this.iconSize = SmeupLabelModel.defaultIconSize,
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    this.model = SmeupLabelModel(
        id: id,
        type: type,
        valueColName: valueColName,
        padding: padding,
        fontSize: fontSize,
        align: align,
        fontbold: fontbold,
        width: width,
        height: height,
        clientData: clientData,
        colorColName: colorColName,
        backColor: backColor,
        fontColor: fontColor,
        iconData: iconData,
        iconColname: iconColname,
        colorFontColName: colorFontColName,
        iconSize: iconSize,
        title: title);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupLabelModel m = model;
    id = m.id;
    type = m.type;
    valueColName = m.valueColName;
    padding = m.padding;
    fontSize = m.fontSize;
    align = m.align;
    fontbold = m.fontbold;
    width = m.width;
    height = m.height;
    clientData = m.clientData;
    colorColName = m.colorColName;
    backColor = m.backColor;
    fontColor = m.fontColor;
    iconData = m.iconData;
    iconColname = m.iconColname;
    colorFontColName = m.colorFontColName;
    iconSize = m.iconSize;
    title = m.title;
  }

  @override
  _SmeupLabelState createState() => _SmeupLabelState();
}

class _SmeupLabelState extends State<SmeupLabel>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupLabelModel _model;

  @override
  void initState() {
    _model = widget.model;
    widgetLoadType = _model.widgetLoadType;
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
        notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return label;
  }

  /// Label's structure:
  ///
  /// Container (widget)
  ///     Row
  ///         Container (label)
  ///               Padding (children)
  ///                   Column (col)
  ///                       List<Align> (alignes)
  ///                             Align (align)
  ///                                 Text
  ///
  ///         Icon (icon)
  ///
  @override
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      await SmeupLabelDao.getData(_model);
      setDataLoad(widget.id, true);
    }

    if (!hasData(_model)) {
      return getFunErrorResponse(context, _model);
    }

    Widget children;

    List<Align> alignes = List<Align>.empty(growable: true);
    double padding = widget.padding;
    double fontSize = widget.fontSize;

    Color backColor = widget.backColor;
    if (widget.colorColName.isNotEmpty &&
        _model.data[0][widget.colorColName] != null) {
      backColor = _model.data[0][widget.colorColName];
    }

    Color fontColor = widget.fontColor;
    if (widget.colorFontColName.isNotEmpty &&
        _model.data[0][widget.colorFontColName] != null) {
      fontColor = _model.data[0][widget.colorFontColName];
    }

    (_model.data as List).forEach((l) {
      var map = (l as Map);
      final align = Align(
        alignment: widget.align,
        child: Text(
          map['value'],
          // key: Key('pippo'),
          style: TextStyle(
              color: fontColor,
              fontWeight: widget.fontbold ? FontWeight.bold : FontWeight.normal,
              fontSize: fontSize),
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
      children = Padding(
        padding: EdgeInsets.all(padding),
        child: col,
      );

      double labelHeight =
          widget.height * alignes.length + padding * (fontSize / 5);

      int iconData = 0;
      if (widget.iconData != 0) {
        iconData = widget.iconData;
      }
      if (widget.iconColname.isNotEmpty &&
          _model.data[0][widget.iconColname] != null) {
        iconData = _model.data[0][widget.iconColname];
      }

      double iconHeight = widget.iconSize;

      if (iconData == 0) {
        return SmeupWidgetBuilderResponse(_model,
            Container(color: backColor, height: labelHeight, child: children));
      } else {
        final label =
            Container(color: backColor, height: labelHeight, child: children);

        final icon = Icon(
          IconData(iconData, fontFamily: 'MaterialIcons'),
          color: fontColor,
          size: iconHeight,
        );

        var widget;
        double widgetHeight = labelHeight + iconHeight;

        switch (widget.align.toString()) {
          case 'centerLeft': // text on the left icon on the right
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
          case 'centerRight': // text on the right icon on the left
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  icon,
                  label,
                ],
              ),
              color: backColor,
            );
            break;
          case 'topCenter': // text at the top icon at the bottom
            widget = Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
          case 'bottomCenter': // text at the bottom icon at the top
            widget = Container(
              height: widgetHeight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(child: icon),
                  label,
                ],
              ),
              color: backColor,
            );

            break;
          default:
            widget = Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  label,
                  icon,
                ],
              ),
              color: backColor,
            );
            break;
        }

        return SmeupWidgetBuilderResponse(_model, widget);
      }
    }

    SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: LogType.error);

    return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
  }
}
