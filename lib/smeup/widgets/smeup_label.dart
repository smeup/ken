import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_label_dao.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
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
    runControllerActivities();
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
  runControllerActivities() {
    //print('setUIProperties in label');

    if (fontColor == null)
      fontColor = SmeupOptions.theme.textTheme.bodyText1.color;
    if (smeupLabelModel.id.isEmpty)
      smeupLabelModel.id = 'LAB' + Random().nextInt(100).toString();

    smeupLabelModel.valueColName =
        smeupLabelModel.optionsDefault['valueColName'] ?? '';
    smeupLabelModel.colorColName =
        smeupLabelModel.optionsDefault['colorColName'] ?? '';
    smeupLabelModel.colorFontColName =
        smeupLabelModel.optionsDefault['colorFontColName'] ?? '';
    smeupLabelModel.padding =
        SmeupUtilities.getDouble(smeupLabelModel.optionsDefault['padding']) ??
            SmeupLabelModel.defaultPadding;
    smeupLabelModel.fontSize =
        SmeupUtilities.getDouble(smeupLabelModel.optionsDefault['fontSize']) ??
            SmeupLabelModel.defaultFontSize;
    smeupLabelModel.iconSize =
        SmeupUtilities.getDouble(smeupLabelModel.optionsDefault['iconSize']) ??
            SmeupLabelModel.defaultIconSize;
    smeupLabelModel.align = SmeupUtilities.getAlignmentGeometry(
        smeupLabelModel.optionsDefault['align']);
    smeupLabelModel.width =
        SmeupUtilities.getDouble(smeupLabelModel.optionsDefault['width']) ??
            SmeupLabelModel.defaultWidth;
    smeupLabelModel.height =
        SmeupUtilities.getDouble(smeupLabelModel.optionsDefault['height']) ??
            SmeupLabelModel.defaultHeight;
    smeupLabelModel.title = smeupLabelModel.jsonMap['title'] ?? '';
    if (smeupLabelModel.optionsDefault['backColor'] != null) {
      smeupLabelModel.backColor = SmeupUtilities.getColorFromRGB(
          smeupLabelModel.optionsDefault['backColor']);
    }
    if (smeupLabelModel.optionsDefault['fontColor'] != null) {
      smeupLabelModel.fontColor = SmeupUtilities.getColorFromRGB(
          smeupLabelModel.optionsDefault['fontColor']);
    }
    if (smeupLabelModel.optionsDefault['icon'] != null)
      smeupLabelModel.iconData =
          int.tryParse(smeupLabelModel.optionsDefault['icon']) ?? 0;
    else
      smeupLabelModel.iconData = 0;
    smeupLabelModel.iconColname =
        smeupLabelModel.optionsDefault['iconColName'] ?? '';
    if (smeupLabelModel.optionsDefault['fontBold'] == null) {
      smeupLabelModel.fontbold = SmeupLabelModel.defaultFontbold;
    } else {
      if (smeupLabelModel.optionsDefault['fontBold'] is bool)
        smeupLabelModel.fontbold = smeupLabelModel.optionsDefault['fontBold'];
      else if (smeupLabelModel.optionsDefault['fontBold'] == 'Yes')
        smeupLabelModel.fontbold = true;
      else
        smeupLabelModel.fontbold = false;
    }
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
    runDispose(widget.scaffoldKey, smeupLabelModel);
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

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    //await smeupLabelModel.setData();
    if (!smeupLabelModel.loaded) {
      smeupLabelModel.data = await SmeupLabelDao.getData(smeupLabelModel);
      smeupLabelModel.loaded = true;
    }

    if (!smeupLabelModel.hasData()) {
      return getFunErrorResponse(context, smeupLabelModel);
    }

    Widget children;

    List<Align> alignes = List<Align>.empty(growable: true);
    double padding = smeupLabelModel.padding;
    double fontSize = smeupLabelModel.fontSize;

    Color backColor = smeupLabelModel.backColor;
    if (smeupLabelModel.colorColName.isNotEmpty &&
        smeupLabelModel.data[0][smeupLabelModel.colorColName] != null) {
      backColor = smeupLabelModel.data[0][smeupLabelModel.colorColName];
    }

    Color fontColor = smeupLabelModel.fontColor;
    if (smeupLabelModel.colorFontColName.isNotEmpty &&
        smeupLabelModel.data[0][smeupLabelModel.colorFontColName] != null) {
      fontColor = smeupLabelModel.data[0][smeupLabelModel.colorFontColName];
    }

    (smeupLabelModel.data as List).forEach((l) {
      var map = (l as Map);
      final align = Align(
        alignment: smeupLabelModel.align,
        child: Text(
          map['value'],
          style: TextStyle(
              color: fontColor,
              fontWeight: smeupLabelModel.fontbold
                  ? FontWeight.bold
                  : FontWeight.normal,
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
          smeupLabelModel.height * alignes.length + padding * (fontSize / 5);

      final label =
          Container(color: backColor, height: labelHeight, child: children);

      int iconData = 0;
      if (smeupLabelModel.iconData != 0) {
        iconData = smeupLabelModel.iconData;
      }
      if (smeupLabelModel.iconColname.isNotEmpty &&
          smeupLabelModel.data[0][smeupLabelModel.iconColname] != null) {
        iconData = smeupLabelModel.data[0][smeupLabelModel.iconColname];
      }

      double iconHeight = smeupLabelModel.iconSize;

      if (iconData == 0) {
        return SmeupWidgetBuilderResponse(smeupLabelModel, label);
      } else {
        final icon = Icon(
          IconData(iconData, fontFamily: 'MaterialIcons'),
          color: fontColor,
          size: smeupLabelModel.iconSize,
        );

        var widget;
        double widgetHeight = labelHeight + iconHeight;

        switch (smeupLabelModel.align.toString()) {
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
