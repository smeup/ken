import 'package:flutter/material.dart';
import 'package:ken/smeup/daos/smeup_switch_dao.dart';
import 'package:ken/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/models/widgets/smeup_section_model.dart';
import 'package:ken/smeup/models/widgets/smeup_switch_model.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_switch_widget.dart';
import 'package:ken/smeup/widgets/smeup_widget_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_mixin.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:ken/smeup/widgets/smeup_widget_state_mixin.dart';

// ignore: must_be_immutable
class SmeupSwitch extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  SmeupSwitchModel? model;

  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? captionFontBold;
  Color? thumbColor;
  Color? trackColor;

  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  String? text;
  String? id;
  String? type;
  String? title;
  bool? data;
  Function? onClientChange;

  SmeupSwitch.withController(
    SmeupSwitchModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupSwitch(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'FLD',
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.captionFontBold,
    this.thumbColor,
    this.trackColor,
    this.title = '',
    this.onClientChange,
    this.data = false,
    this.text = '',
    this.width = SmeupSwitchModel.defaultWidth,
    this.height = SmeupSwitchModel.defaultHeight,
    this.padding = SmeupSwitchModel.defaultPadding,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupSwitchModel.setDefaults(this);
  }

  @override
  runControllerActivities(SmeupModel model) {
    SmeupSwitchModel m = model as SmeupSwitchModel;
    id = m.id;
    type = m.type;
    title = m.title;
    width = m.width;
    height = m.height;
    captionFontSize = m.captionFontSize;
    captionFontBold = m.captionFontBold;
    captionFontColor = m.captionFontColor;
    captionBackColor = m.captionBackColor;
    thumbColor = m.thumbColor;
    trackColor = m.trackColor;
    padding = m.padding;

    data = treatData(m);
  }

  @override
  dynamic treatData(SmeupModel model) {
    SmeupSwitchModel m = model as SmeupSwitchModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      text = workData['rows'][0]['txt'];
      final value = SmeupUtilities.getInt(workData['rows'][0]['value']);
      if (value == 1)
        return true;
      else
        return false;
    } else {
      return model.data;
    }
  }

  @override
  _SmeupSwitchState createState() => _SmeupSwitchState();
}

class _SmeupSwitchState extends State<SmeupSwitch>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  bool? _data;
  SmeupSwitchModel? _model;

  @override
  void initState() {
    SmeupVariablesService.setVariable(widget.id, _data,
        formKey: widget.formKey);
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
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupSwitchDao.getData(_model!);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    double? switchHeight = widget.height;
    double? switchWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (switchHeight == 0)
        switchHeight = (_model!.parent as SmeupSectionModel).height;
      if (switchWidth == 0)
        switchWidth = (_model!.parent as SmeupSectionModel).width;
    } else {
      if (switchHeight == 0) switchHeight = MediaQuery.of(context).size.height;
      if (switchWidth == 0) switchWidth = MediaQuery.of(context).size.width;
    }

    TextStyle captionStyle = _getCaptionStile();

    final children = Center(
        child: Container(
      padding: widget.padding,
      width: switchWidth,
      height: switchHeight,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            widget.text!,
            style: captionStyle,
          ),
          SmeupSwitchWidget(
            data: _data,
            id: widget.id,
            onClientChange: (changedValue) {
              _data = changedValue;
              SmeupVariablesService.setVariable(widget.id, _data,
                  formKey: widget.formKey);
              if (widget.onClientChange != null) {
                widget.onClientChange!(changedValue);
              }
              if (_model != null)
                SmeupDynamismService.run(_model!.dynamisms, context, 'click',
                    widget.scaffoldKey, widget.formKey);
            },
          ),
        ],
      ),
    ));

    return SmeupWidgetBuilderResponse(_model, children);
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
