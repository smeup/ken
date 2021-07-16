import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_label_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupLabel extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupLabelModel smeupLabelModel;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

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

  SmeupLabel.withController(
    this.smeupLabelModel,
    this.scaffoldKey,
    this.formKey,
  ) {
    runControllerActivities(smeupLabelModel);
  }

  SmeupLabel(this.scaffoldKey, this.formKey,
      {this.valueColName = '',
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
      this.title = ''}) {
    this.smeupLabelModel = SmeupLabelModel(
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
  SmeupLabelModel smeupLabelModel;

  @override
  void initState() {
    smeupLabelModel = widget.smeupLabelModel;
    super.initState();
  }

  @override
  void dispose() {
    runDispose(widget.scaffoldKey, smeupLabelModel.id);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Widget label = runBuild(context, smeupLabelModel, widget.scaffoldKey,
        notifierFunction: () {
      setState(() {});
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
    //await smeupLabelModel.setData();
    if (!smeupLabelModel.dataLoaded) {
      smeupLabelModel.data = await SmeupLabelDao.getData(smeupLabelModel);
      smeupLabelModel.dataLoaded = true;
    }

    if (!hasData(smeupLabelModel)) {
      return getFunErrorResponse(context, smeupLabelModel);
    }

    Widget children;

    List<Align> alignes = List<Align>.empty(growable: true);
    double padding = widget.padding;
    double fontSize = widget.fontSize;

    Color backColor = widget.backColor;
    if (widget.colorColName.isNotEmpty &&
        smeupLabelModel.data[0][widget.colorColName] != null) {
      backColor = smeupLabelModel.data[0][widget.colorColName];
    }

    Color fontColor = widget.fontColor;
    if (widget.colorFontColName.isNotEmpty &&
        smeupLabelModel.data[0][widget.colorFontColName] != null) {
      fontColor = smeupLabelModel.data[0][widget.colorFontColName];
    }

    (smeupLabelModel.data as List).forEach((l) {
      var map = (l as Map);
      final align = Align(
        alignment: widget.align,
        child: Text(
          map['value'],
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

      final label =
          Container(color: backColor, height: labelHeight, child: children);

      int iconData = 0;
      if (widget.iconData != 0) {
        iconData = widget.iconData;
      }
      if (widget.iconColname.isNotEmpty &&
          smeupLabelModel.data[0][widget.iconColname] != null) {
        iconData = smeupLabelModel.data[0][widget.iconColname];
      }

      double iconHeight = widget.iconSize;

      if (iconData == 0) {
        return SmeupWidgetBuilderResponse(smeupLabelModel, label);
      } else {
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

        return SmeupWidgetBuilderResponse(smeupLabelModel, widget);
      }
    }

    SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: LogType.error);

    return SmeupWidgetBuilderResponse(smeupLabelModel, SmeupNotAvailable());
  }
}
