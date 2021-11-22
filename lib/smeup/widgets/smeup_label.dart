import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_label_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_label_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
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
  double fontSize;
  Color fontColor;
  bool fontBold;
  Color backColor;
  double iconSize;
  Color iconColor;

  EdgeInsetsGeometry padding;
  Alignment align;
  double width;
  double height;
  List<String> data;
  String valueColName;
  String backColorColName;
  String fontColorColName;
  int iconData;
  String iconColname;
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

  SmeupLabel(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'LAB',
      this.fontSize,
      this.fontBold,
      this.fontColor,
      this.backColor,
      this.iconSize,
      this.iconColor,
      this.valueColName = SmeupLabelModel.defaultValColName,
      this.padding = SmeupLabelModel.defaultPadding,
      this.align = SmeupLabelModel.defaultAlign,
      this.width = SmeupLabelModel.defaultWidth,
      this.height = SmeupLabelModel.defaultHeight,
      this.backColorColName = '',
      this.iconData = 0,
      this.iconColname = '',
      this.fontColorColName = '',
      this.title = ''})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupLabelModel.setDefaults(this);
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
    fontBold = m.fontBold;
    width = m.width;
    height = m.height;
    backColorColName = m.backColorColName;
    backColor = m.backColor;
    fontColor = m.fontColor;
    iconData = m.iconData;
    iconColname = m.iconColname;
    fontColorColName = m.fontColorColName;
    iconSize = m.iconSize;
    iconColor = m.iconColor;
    title = m.title;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupLabelModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);

      // overrides model properties from data
      var firstElement = (workData['rows'] as List).first;
      if (firstElement != null) {
        if (firstElement[m.optionsDefault['iconColName']] != null) {
          m.iconData = SmeupUtilities.getInt(
                  firstElement[m.optionsDefault['iconColName']]) ??
              0;
        }

        if (firstElement[m.optionsDefault['backColorColName']] != null) {
          m.backColor = SmeupUtilities.getColorFromRGB(
              firstElement[m.optionsDefault['backColorColName']]);
        }

        if (firstElement[m.optionsDefault['fontColorColName']] != null) {
          m.fontColor = SmeupUtilities.getColorFromRGB(
              firstElement[m.optionsDefault['fontColorColName']]);
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
  _SmeupLabelState createState() => _SmeupLabelState();
}

class _SmeupLabelState extends State<SmeupLabel>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupLabelModel _model;
  dynamic _data;

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
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupLabelDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    List<Align> alignes = List<Align>.empty(growable: true);

    _data.forEach((text) {
      final align = Align(
        alignment: widget.align,
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
          widget.height * alignes.length * (widget.fontSize / 5);

      double labelWidth = widget.width;
      if (labelWidth == 0) {
        if (_model != null && _model.parent != null) {
          labelWidth = (_model.parent as SmeupSectionModel).width;
        } else {
          labelWidth = MediaQuery.of(context).size.width;
        }
      }

      int iconData = 0;
      if (widget.iconData != 0) {
        iconData = widget.iconData;
      }

      if (iconData == 0) {
        return SmeupWidgetBuilderResponse(
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
          IconData(iconData, fontFamily: 'MaterialIcons'),
          color: iconTheme.color,
          size: iconTheme.size,
        );

        var children;
        double widgetHeight = labelHeight + iconTheme.size;

        if (widget.align == Alignment.centerLeft) {
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
        } else if (widget.align == Alignment.centerRight) {
          children = Container(
            padding: widget.padding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
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

        return SmeupWidgetBuilderResponse(_model, children);
      }
    }

    SmeupLogService.writeDebugMessage('Error SmeupLabel not created',
        logType: LogType.error);

    return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
  }

  TextStyle _getTextStile() {
    TextStyle style =
        SmeupConfigurationService.getTheme().textTheme.copyWith().bodyText2;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

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
