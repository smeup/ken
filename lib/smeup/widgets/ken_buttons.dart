import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_buttons_model.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/widgets/ken_button.dart';
import 'package:ken/smeup/widgets/ken_enum_callback.dart';
import 'package:ken/smeup/widgets/ken_widget_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_mixin.dart';
import 'package:ken/smeup/widgets/ken_widget_state_interface.dart';
import 'package:ken/smeup/widgets/ken_widget_state_mixin.dart';


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
  Future<dynamic> Function(Widget,KenCallbackType,dynamic,dynamic)? callBack;

  KenButtons.withController(
    KenButtonsModel this.model,
    this.scaffoldKey,
    this.formKey,
      this.iconData,
      this.callBack
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenButtons(this.scaffoldKey, this.formKey,
      {this.id = '',
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
      this.clientOnPressed, this.callBack
      })
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenButtonsModel.setDefaults(this);
    if (data == null) data = List<String>.empty(growable: true);
  }

  @override
  runControllerActivities(KenModel model) {
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
    isBusy = false;
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

        await _model!.getData(_model!.instanceCallBack);
        // await SmeupButtonsDao.getData(_model!);
        _data = widget.treatData(_model!);
      }

      setDataLoad(widget.id, true);
    }

    var buttons = List<KenButton>.empty(growable: true);


    if (widget.callBack != null) {
      buttons = await widget.callBack!(widget,KenCallbackType.getButtons, _model,_data);
    }

    // vecchia versione
    // int buttonIndex = 0;
    // List array = _model == null ? _data : _data['rows'];
    //
    // array.forEach((buttonData) {
    //   buttonIndex += 1;
    //   String? buttonText = _model == null ? buttonData : buttonData['value'];
    //   final button = KenButton(
    //     id: '${KenUtilities.getWidgetId(widget.type, widget.id)}_${buttonIndex.toString()}',
    //     type: widget.type,
    //     buttonIndex: buttonIndex,
    //     title: widget.title,
    //     data: buttonText,
    //     backColor: widget.backColor,
    //     borderColor: widget.borderColor,
    //     width: widget.width,
    //     height: widget.height,
    //     position: widget.position,
    //     align: widget.align,
    //     fontColor: widget.fontColor,
    //     fontSize: widget.fontSize,
    //     padding: widget.padding,
    //     valueField: widget.valueField,
    //     borderRadius: widget.borderRadius,
    //     borderWidth: widget.borderWidth,
    //     elevation: widget.elevation,
    //     fontBold: widget.fontBold,
    //     //iconCode: widget.iconCode,
    //     iconSize: widget.iconSize,
    //     iconColor: widget.iconColor,
    //     //icon: null,
    //     //isBusy: _isBusy,
    //     clientOnPressed: () {
    //       if (widget.clientOnPressed != null) {
    //         widget.clientOnPressed!(buttonIndex, buttonText);
    //       }
    //       //runDynamism(context, buttonData);
    //     },
    //     isLink: widget.isLink!,
    //     model: _model,
    //   );
    //
    //   buttons.add(button);
    // });


    if (buttons.length > 0) {
      var widgets;
      if (widget.orientation == WidgetOrientation.Vertical)
        widgets = SingleChildScrollView(
            scrollDirection: Axis.vertical, child: Column(children: buttons));
      else
        widgets = SingleChildScrollView(
            scrollDirection: Axis.horizontal, child: Row(children: buttons));

      return KenWidgetBuilderResponse(_model, widgets);
    } else {
      KenLogService.writeDebugMessage(
          'Error SmeupButtons no children \'button\' created',
          logType: KenLogType.warning);
      final column = Column(children: [Container()]);
      return KenWidgetBuilderResponse(_model, column);
    }
  }

}
