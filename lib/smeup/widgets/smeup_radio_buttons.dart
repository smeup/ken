import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_radio_buttons_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_radio_buttons_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_not_available.dart';
import 'package:ken/smeup/widgets/smeup_radio_button.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupRadioButtons extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupRadioButtonsModel model;
  SmeupRadioButtonsModel smeupRadioButtonsModel;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState> formKey;

  Color radioButtonColor;
  Color fontColor;
  double fontSize;
  Color backColor;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;

  Function clientOnPressed;
  EdgeInsetsGeometry padding;
  double width;
  double height;
  Alignment align;
  List<dynamic> data;
  String valueField;
  String displayedField;
  String selectedValue;
  int columns;
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

  SmeupRadioButtons(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'FLD',
    this.title = '',
    this.radioButtonColor,
    this.fontSize,
    this.fontColor,
    this.backColor,
    this.fontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.captionFontBold,
    this.data,
    this.width = SmeupRadioButtonsModel.defaultWidth,
    this.height = SmeupRadioButtonsModel.defaultHeight,
    this.align = SmeupRadioButtonsModel.defaultAlign,
    this.padding = SmeupRadioButtonsModel.defaultPadding,
    this.valueField = SmeupRadioButtonsModel.defaultValueField,
    this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
    this.selectedValue,
    this.clientOnPressed(String value),
    this.columns = SmeupRadioButtonsModel.defaultColumns,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupRadioButtonsModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupRadioButtonsModel m = model;
    id = m.id;
    type = m.type;
    title = m.title;
    backColor = m.backColor;
    width = m.width;
    height = m.height;
    align = m.align;
    fontColor = m.fontColor;
    fontSize = m.fontSize;
    padding = m.padding;
    valueField = m.valueField;
    displayedField = m.displayedField;
    selectedValue = m.selectedValue;
    columns = m.columns;
    radioButtonColor = m.radioButtonColor;
    fontBold = m.fontBold;
    captionBackColor = m.captionBackColor;
    captionFontBold = m.captionFontBold;
    captionFontColor = m.captionFontColor;
    captionFontSize = m.captionFontSize;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupRadioButtonsModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      var newList = List<dynamic>.empty(growable: true);
      for (var i = 0; i < (workData['rows'] as List).length; i++) {
        final element = workData['rows'][i];
        newList.add({
          'code': element[m.valueField].toString(),
          'value': element[m.displayedField].toString()
        });
      }
      return newList;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupRadioButtonsState createState() => _SmeupRadioButtonsState();
}

class _SmeupRadioButtonsState extends State<SmeupRadioButtons>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  dynamic _data;
  SmeupRadioButtonsModel _model;

  @override
  void initState() {
    SmeupVariablesService.setVariable(widget.id, widget.selectedValue,
        formKey: widget.formKey);
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
    final radioButtons = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return radioButtons;
  }

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupRadioButtonsDao.getData(_model);
        _data = widget.treatData(_model);
      }

      setDataLoad(widget.id, true);
    }

    var buttons = List<Widget>.empty(growable: true);

    TextStyle captionStyle = _getCaptionStile();

    if (widget.title.isNotEmpty) {
      buttons.add(Container(
          child: Text(
        widget.title,
        style: captionStyle,
      )));
    }

    int buttonIndex = 0;
    double radioHeight = widget.height;
    double radioWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (radioHeight == 0)
        radioHeight = (_model.parent as SmeupSectionModel).height;
      if (radioWidth == 0)
        radioWidth = (_model.parent as SmeupSectionModel).width;
    } else {
      if (radioHeight == 0) radioHeight = MediaQuery.of(context).size.height;
      if (radioWidth == 0) radioWidth = MediaQuery.of(context).size.width;
    }

    _data.forEach((radioButtonData) {
      buttonIndex += 1;

      final button = SmeupRadioButton(
          id:
              '${SmeupUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
          type: widget.type,
          title: widget.title,
          data: radioButtonData,
          backColor: widget.backColor,
          width: radioWidth,
          height: radioHeight,
          align: widget.align,
          fontColor: widget.fontColor,
          fontSize: widget.fontSize,
          padding: widget.padding,
          valueField: widget.valueField,
          displayedField: widget.displayedField,
          radioButtonColor: widget.radioButtonColor,
          selectedValue: SmeupVariablesService.getVariable(widget.id,
              formKey: widget.formKey),
          icon: null,
          onPressed: (value) {
            dynamic selData = _data.firstWhere(
                (element) => element['code'] == value,
                orElse: () => null);
            if (selData != null) {
              SmeupDynamismService.storeDynamicVariables(
                  selData, widget.formKey);
              SmeupVariablesService.setVariable(widget.id, value,
                  formKey: widget.formKey);
              if (widget.clientOnPressed != null) widget.clientOnPressed(value);
              if (_model != null) {
                SmeupDynamismService.run(_model.dynamisms, context, 'change',
                    widget.scaffoldKey, widget.formKey);
              }
            }
          });

      if (_model != null)
        SmeupDynamismService.run(_model.dynamisms, context, 'change',
            widget.scaffoldKey, widget.formKey);
      buttons.add(button);
    });

    if (buttons.length > 0) {
      for (var i = 0; i < buttons.length; i++) {
        if (buttons[i] is SmeupRadioButton) {
          var others = List<SmeupRadioButton>.empty(growable: true);
          for (var k = 0; k < buttons.length; k++) {
            if (i != k && buttons[k] is SmeupRadioButton) {
              others.add(buttons[k]);
            }
          }
          (buttons[i] as SmeupRadioButton).others = others;
        }
      }

      double childAspectRatio = 0;
      childAspectRatio =
          (radioWidth / radioHeight * buttons.length * 3) / widget.columns;

      final container = Container(
          padding: widget.padding,
          child: GridView.count(
            shrinkWrap: true,
            childAspectRatio: childAspectRatio,
            crossAxisCount: widget.columns,
            children: buttons,
          ));

      dynamic selData = (_data as List).firstWhere(
          (element) => element == SmeupVariablesService.getVariable(widget.id),
          orElse: () => null);
      if (selData != null) {
        SmeupDynamismService.storeDynamicVariables(selData, widget.formKey);
      }

      return SmeupWidgetBuilderResponse(_model, container);
    } else {
      SmeupLogService.writeDebugMessage(
          'Error SmeupRadioButtons no children \'radio button\' created',
          logType: LogType.error);
      return SmeupWidgetBuilderResponse(_model, SmeupNotAvailable());
    }
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.caption;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
