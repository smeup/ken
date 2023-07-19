// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_section_model.dart';
import '../models/widgets/ken_switch_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenSwitchWidget.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenSwitch extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;
  KenSwitchModel? model;

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

  KenSwitch.withController(
    KenSwitchModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenSwitch(
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
    this.width = KenSwitchModel.defaultWidth,
    this.height = KenSwitchModel.defaultHeight,
    this.padding = KenSwitchModel.defaultPadding,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenSwitchModel.setDefaults(this);
  }

  @override
  runControllerActivities(KenModel model) {
    KenSwitchModel m = model as KenSwitchModel;
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
  dynamic treatData(KenModel model) {
    KenSwitchModel m = model as KenSwitchModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null) {
      text = workData['rows'][0]['txt'];
      final value = KenUtilities.getInt(workData['rows'][0]['value']);
      if (value == 1) {
        return true;
      } else {
        return false;
      }
    } else {
      return model.data;
    }
  }

  @override
  _KenSwitchState createState() => _KenSwitchState();
}

class _KenSwitchState extends State<KenSwitch>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  bool? _data;
  KenSwitchModel? _model;

  @override
  void initState() {
    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenSwitchInitState,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );

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

  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupSwitchDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    double? switchHeight = widget.height;
    double? switchWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (switchHeight == 0) {
        switchHeight = (_model!.parent as KenSectionModel).height;
      }
      if (switchWidth == 0) {
        switchWidth = (_model!.parent as KenSectionModel).width;
      }
    } else {
      if (switchHeight == 0) {
        switchHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
      if (switchWidth == 0) {
        switchWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
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
          KenSwitchWidget(
            data: _data,
            id: widget.id,
            onClientChange: (changedValue) {
              _data = changedValue;

              KenMessageBus.instance.publishRequest(
                widget.globallyUniqueId,
                KenTopic.kenSwitchOnClientChange,
                KenMessageBusEventData(
                    context: context,
                    widget: widget,
                    model: _model,
                    data: _data),
              );
            },
          ),
        ],
      ),
    ));

    return KenWidgetBuilderResponse(_model, children);
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.caption!;

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
