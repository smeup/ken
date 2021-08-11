import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/daos/smeup_radio_buttons_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_not_available.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_radio_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupRadioButtons extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupRadioButtonsModel model;
  SmeupRadioButtonsModel smeupRadioButtonsModel;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color backColor;
  double width;
  double height;
  MainAxisAlignment position;
  Alignment align;
  Color fontColor;
  double fontsize;
  double padding;
  double rightPadding;
  double leftPadding;
  double topPadding;
  double bottomPadding;
  String clientData;
  String valueField;
  String displayedField;
  String selectedValue;

  String id;
  String type;
  String title;

  SmeupRadioButtons.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupRadioButtons(this.scaffoldKey, this.formKey,
      {this.id = '',
      this.type = 'FLD',
      this.clientData = '',
      this.backColor,
      this.width = SmeupRadioButtonsModel.defaultWidth,
      this.height = SmeupRadioButtonsModel.defaultHeight,
      this.position = SmeupRadioButtonsModel.defaultPosition,
      this.align = SmeupRadioButtonsModel.defaultAlign,
      this.fontColor,
      this.fontsize = SmeupRadioButtonsModel.defaultFontsize,
      this.padding = SmeupRadioButtonsModel.defaultPadding,
      this.leftPadding = SmeupRadioButtonsModel.defaultPadding,
      this.rightPadding = SmeupRadioButtonsModel.defaultPadding,
      this.topPadding = SmeupRadioButtonsModel.defaultPadding,
      this.bottomPadding = SmeupRadioButtonsModel.defaultPadding,
      this.valueField = SmeupRadioButtonsModel.defaultValueField,
      this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
      this.selectedValue})
      : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);

    this.model = SmeupRadioButtonsModel(
        id: id,
        type: type,
        title: title,
        clientData: clientData,
        backColor: backColor,
        width: width,
        height: height,
        position: position,
        align: align,
        fontColor: fontColor,
        fontsize: fontsize,
        padding: padding,
        leftPadding: leftPadding,
        rightPadding: rightPadding,
        topPadding: topPadding,
        bottomPadding: bottomPadding,
        valueField: valueField,
        displayedField: displayedField,
        selectedValue: selectedValue);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupRadioButtonsModel m = model;
    clientData = m.clientData;
    backColor = m.backColor;
    width = m.width;
    height = m.height;
    position = m.position;
    align = m.align;
    fontColor = m.fontColor;
    fontsize = m.fontsize;
    padding = m.padding;
    leftPadding = m.leftPadding;
    rightPadding = m.rightPadding;
    topPadding = m.topPadding;
    bottomPadding = m.bottomPadding;
    valueField = m.valueField;
    displayedField = m.displayedField;
    selectedValue = m.selectedValue;
  }

  @override
  _SmeupRadioButtonsState createState() => _SmeupRadioButtonsState();
}

class _SmeupRadioButtonsState extends State<SmeupRadioButtons>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupRadioButtonsModel _model;

  @override
  void initState() {
    SmeupDynamismService.variables[widget.smeupRadioButtonsModel.id] =
        widget.smeupRadioButtonsModel.selectedValue;
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

  Future<SmeupWidgetBuilderResponse> getChildrens() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      await SmeupRadioButtonsDao.getData(_model);
      setDataLoad(widget.id, true);
    }

    if (!hasData(_model)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Dati non disponibili.  (${_model.smeupFun.fun['fun']['function']})'),
          backgroundColor: SmeupOptions.theme.errorColor,
        ),
      );

      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }

    var buttons = List<Widget>.empty(growable: true);

    if (widget.title.isNotEmpty) {
      buttons.add(Container(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          child: Text(
            widget.title,
            style:
                TextStyle(fontSize: widget.fontsize, color: widget.fontColor),
          )));
    }
    int buttonIndex = 0;
    _model.data.forEach((child) {
      buttonIndex += 1;

      final button = SmeupRadioButton(
        id: '${SmeupUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
        type: widget.type,
        title: widget.title,
        clientData: widget.clientData,
        backColor: widget.backColor,
        width: widget.width,
        height: widget.height,
        position: widget.position,
        align: widget.align,
        fontColor: widget.fontColor,
        fontsize: widget.fontsize,
        padding: widget.padding,
        leftPadding: widget.leftPadding,
        rightPadding: widget.rightPadding,
        topPadding: widget.topPadding,
        bottomPadding: widget.bottomPadding,
        valueField: widget.valueField,
        displayedField: widget.displayedField,
        selectedValue: SmeupDynamismService.variables[widget.id],
        icon: null,
        onServerPressed: (value) {
          setState(() {
            dynamic selData = (_model.data as List).firstWhere(
                (element) => element['k'] == value,
                orElse: () => null);
            if (selData != null) {
              SmeupDynamismService.storeDynamicVariables(selData);
              SmeupDynamismService.variables[widget.id] = value;
              SmeupDynamismService.run(
                  _model.dynamisms, context, 'change', widget.scaffoldKey);
            }
          });
        },
        data: child,
      );
      SmeupDynamismService.run(
          _model.dynamisms, context, 'change', widget.scaffoldKey);
      buttons.add(button);
    });

    if (buttons.length > 0) {
      final listView = ListView(children: buttons);
      final container = Container(
          padding: widget.padding > 0
              ? EdgeInsets.all(widget.padding)
              : EdgeInsets.only(
                  top: widget.topPadding,
                  bottom: widget.bottomPadding,
                  right: widget.rightPadding,
                  left: widget.leftPadding),
          child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: SmeupOptions.theme.primaryColor)),
              child: listView));

      dynamic selData = (_model.data as List).firstWhere(
          (element) =>
              element['k'] == SmeupDynamismService.variables[widget.id],
          orElse: () => null);
      if (selData != null) {
        SmeupDynamismService.storeDynamicVariables(selData);
      }

      return SmeupWidgetBuilderResponse(_model, container);
    } else {
      SmeupLogService.writeDebugMessage(
          'Error SmeupRadioButtons no children \'button\' created',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }
  }
}
