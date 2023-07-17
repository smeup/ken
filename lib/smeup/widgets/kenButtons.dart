import 'package:flutter/material.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_buttons_model.dart';
import '../models/widgets/ken_model.dart';
import '../services/ken_log_service.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../models/KenMessageBusEvent.dart';
import '../models/KenMessageBusEventData.dart';

// ignore: must_be_immutable
class KenButtons extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenButtonsModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? backColor;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  double? elevation;
  double? fontSize;
  Color? fontColor;
  bool? fontBold;
  double? iconSize;
  Color? iconColor;

  double? width;
  double? height;
  MainAxisAlignment? position;
  Alignment? align;
  EdgeInsetsGeometry? padding;
  dynamic data;
  String? valueField;
  String? id;
  String? type;
  String? title;
  WidgetOrientation? orientation;
  bool? isLink;
  double? innerSpace;
  Function? clientOnPressed;
  final IconData? iconData;

  KenButtons.withController(
      KenButtonsModel this.model, this.scaffoldKey, this.formKey, this.iconData)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenButtons(
    this.scaffoldKey,
    this.formKey, {
    this.id = '',
    this.type = 'BTN',
    this.title = '',
    this.data,
    this.backColor,
    this.borderColor,
    this.borderRadius,
    this.borderWidth,
    this.elevation,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.iconSize,
    this.iconColor,
    this.width = KenButtonsModel.defaultWidth,
    this.height = KenButtonsModel.defaultHeight,
    this.position = KenButtonsModel.defaultPosition,
    this.align = KenButtonsModel.defaultAlign,
    this.padding = KenButtonsModel.defaultPadding,
    this.valueField = KenButtonsModel.defaultValueField,
    this.iconData,
    this.orientation = KenButtonsModel.defaultOrientation,
    this.isLink = KenButtonsModel.defaultIsLink,
    this.innerSpace = KenButtonsModel.defaultInnerSpace,
    this.clientOnPressed,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenButtonsModel.setDefaults(this);
    data ??= List<String>.empty(growable: true);
  }

  @override
  runControllerActivities(KenModel model) {
    // controller mvC - stato widget
    KenButtonsModel m = model as KenButtonsModel;
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
    fontSize = m.fontSize;
    padding = m.padding;
    valueField = m.valueField;
    borderRadius = m.borderRadius;
    borderWidth = m.borderWidth;
    elevation = m.elevation;
    fontBold = m.fontBold;
    iconSize = m.iconSize;
    iconColor = m.iconColor;
    orientation = m.orientation;
    isLink = m.isLink;
    innerSpace = m.innerSpace;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenButtonsModel m = model as KenButtonsModel;

    // change data format
    return formatDataFields(m);
  }

  @override
  KenButtonsState createState() => KenButtonsState();
}

class KenButtonsState extends State<KenButtons>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  bool? isBusy;
  KenButtonsModel? _model;
  dynamic _data;

  @override
  void initState() {
    // inizializzazione v
    isBusy = false;
    _model = widget.model; //
    _data = widget.data;
    if (_model != null) widgetLoadType = _model!.widgetLoadType;
    super.initState();
  }

  @override
  void dispose() {
    // pulizia
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
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await _model!.getData();
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.buttonsGetChildren,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );
    return KenWidgetBuilderResponse(
      _model,
      StreamBuilder(
        stream: KenMessageBus.instance.response(
            id: widget.globallyUniqueId, topic: KenTopic.buttonsGetChildren),
        initialData: KenMessageBusEvent(
          id: widget.globallyUniqueId,
          data: KenMessageBusEventData(
            data: <Widget>[],
            context: context,
            widget: widget,
            model: _model,
          ),
          topic: KenTopic.buttonsGetChildren,
          messageType: KenMessageType.response,
        ),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }

          var buttons = snapshot.data!.data.data;

          if (buttons.length > 0) {
            var widgets;
            if (widget.orientation == WidgetOrientation.Vertical) {
              widgets = SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(children: buttons));
            } else {
              widgets = SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: buttons));
            }

            return widgets;
          } else {
            KenLogService.writeDebugMessage(
                'Error SmeupButtons no children \'button\' created',
                logType: KenLogType.warning);
            final column = Column(children: [Container()]);
            return column;
          }
        },
      ),
    );
  }
}
