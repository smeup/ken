import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_buttons_dao.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_buttons_model.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupButtons extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupButtonsModel model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color backColor;
  Color borderColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontsize;
  EdgeInsetsGeometry padding;
  List<String> data;
  String valueField;
  double borderRadius;
  double elevation;
  bool bold;
  double iconSize;
  int iconData;
  String id;
  String type;
  String title;

  SmeupButtons.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupButtons(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'BTN',
    this.title = '',
    this.data,
    this.backColor,
    this.borderColor,
    this.width = SmeupButtonsModel.defaultWidth,
    this.height = SmeupButtonsModel.defaultHeight,
    this.position = SmeupButtonsModel.defaultPosition,
    this.align = SmeupButtonsModel.defaultAlign,
    this.fontColor,
    this.fontsize = SmeupButtonsModel.defaultFontsize,
    this.padding = SmeupButtonsModel.defaultPadding,
    this.valueField,
    this.borderRadius = SmeupButtonsModel.defaultBorderRadius,
    this.elevation = SmeupButtonsModel.defaultElevation,
    this.bold = SmeupButtonsModel.defaultBold,
    this.iconData = 0,
    this.iconSize = SmeupButtonsModel.defaultIconSize,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    if (data == null) data = List<String>.empty(growable: true);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupButtonsModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    backColor = m.backColor;
    borderColor = m.borderColor;
    width = m.width;
    height = m.height;
    position = m.position;
    align = m.align;
    fontColor = m.fontColor;
    fontsize = m.fontsize;
    padding = m.padding;
    valueField = m.valueField;
    borderRadius = m.borderRadius;
    elevation = m.elevation;
    bold = m.bold;
    iconData = m.iconData;
    iconSize = m.iconSize;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupButtonsModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<String>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add(element[m.valueField].toString());
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  SmeupButtonsState createState() => SmeupButtonsState();
}

class SmeupButtonsState extends State<SmeupButtons>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  bool _isBusy;
  SmeupButtonsModel _model;
  dynamic _data;

  @override
  void initState() {
    _isBusy = false;
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
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return buttons;
  }

  /// Buttons' structure:
  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupButtonsDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    // if (!hasData(_model)) {
    //   return getFunErrorResponse(context, _model);
    // }

    var buttons = List<SmeupButton>.empty(growable: true);

    double buttonHeight = widget.height;
    double buttonWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (buttonHeight == 0)
        buttonHeight = (_model.parent as SmeupSectionModel).height;
      if (buttonWidth == 0)
        buttonWidth = (_model.parent as SmeupSectionModel).width;
    }

    int buttonIndex = 0;
    _data.forEach((buttonData) {
      buttonIndex += 1;
      final button = SmeupButton(
          id: '${SmeupUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
          type: widget.type,
          buttonIndex: buttonIndex,
          title: widget.title,
          data: buttonData,
          backColor: widget.backColor,
          borderColor: widget.borderColor,
          width: buttonWidth,
          height: buttonHeight,
          position: widget.position,
          align: widget.align,
          fontColor: widget.fontColor,
          fontsize: widget.fontsize,
          padding: widget.padding,
          valueField: widget.valueField,
          borderRadius: widget.borderRadius,
          elevation: widget.elevation,
          bold: widget.bold,
          iconData: widget.iconData,
          iconSize: widget.iconSize,
          //data: buttonData,
          icon: null,
          isBusy: _isBusy,
          clientOnPressed: () {
            runDynamism(_model, context, buttonData);
          });

      buttons.add(button);
    });

    if (buttons.length > 0) {
      final column = Column(children: buttons);
      return SmeupWidgetBuilderResponse(_model, column);
    } else {
      SmeupLogService.writeDebugMessage(
          'Error SmeupButtons no children \'button\' created',
          logType: LogType.warning);
      final column = Column(children: [Container()]);
      return SmeupWidgetBuilderResponse(_model, column);
    }
  }

  void runDynamism(
      SmeupButtonsModel modelClone, BuildContext context, dynamic child) async {
    if (_isDinamismAsync(modelClone)) {
      execDynamismActions(modelClone, child, true);

      SmeupLogService.writeDebugMessage('********************* ASYNC = TRUE',
          logType: LogType.info);
    } else {
      if (_isBusy) {
        SmeupLogService.writeDebugMessage(
            '********************* SKIPPED DOUBLE CLICK',
            logType: LogType.warning);
        return;
      } else {
        SmeupLogService.writeDebugMessage('********************* ASYNC = FALSE',
            logType: LogType.info);

        setState(() {
          _isBusy = true;
        });

        await execDynamismActions(modelClone, child, false);

        setState(() {
          _isBusy = false;
        });
      }
    }
  }

  bool _isDinamismAsync(SmeupButtonsModel modelClone) {
    return modelClone.smeupFun != null
        ? modelClone.smeupFun.isDinamismAsync(modelClone.dynamisms, 'click')
        : false;
  }

  Future<void> execDynamismActions(
      SmeupButtonsModel modelClone, dynamic child, bool isAsync) async {
    SmeupDynamismService.storeDynamicVariables(child, widget.formKey);

    if (isAsync)
      SmeupDynamismService.run(modelClone.dynamisms, context, 'click',
          widget.scaffoldKey, widget.formKey);
    else
      await SmeupDynamismService.run(modelClone.dynamisms, context, 'click',
          widget.scaffoldKey, widget.formKey);
  }
}
