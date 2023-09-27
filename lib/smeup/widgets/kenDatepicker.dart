// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/ken_widget_builder_response.dart';
import '../models/widgets/ken_datepicker_model.dart';
import '../models/widgets/ken_model.dart';
import '../models/widgets/ken_section_model.dart';
import '../services/ken_message_bus.dart';
import '../services/ken_utilities.dart';
import 'kenDatepickerButton.dart';
import 'kenLine.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';
import 'kenWidgetStateInterface.dart';
import 'kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

class KenDatePickerData {
  DateTime? value;
  String? text;
  KenDatePickerData({required this.value, this.text});
}

// ignore: must_be_immutable
class KenDatePicker extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenDatePickerModel? model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState>? formKey;

  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  bool? fontBold;
  double? fontSize;
  Color? fontColor;
  Color? backColor;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? underline;
  double? innerSpace;
  Alignment? align;
  KenDatePickerData? data;
  String? title;
  String? id;
  String? type;
  String? valueField;
  String? displayField;
  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showborder;
  double? elevation;
  Color? dashColor;

  //Functions
  Function? clientValidator;
  Function? clientOnSave;
  Function? clientOnChange;

  KenDatePicker.withController(
    KenDatePickerModel this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  KenDatePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    this.id = '',
    this.type = 'cal',
    this.title = '',
    this.borderColor = KenDatePickerModel.defaultBorderColor,
    this.borderWidth = KenDatePickerModel.defaultBorderWidth,
    this.borderRadius = KenDatePickerModel.defaultBorderRadius,
    this.fontBold = KenDatePickerModel.defaultFontBold,
    this.fontSize = KenDatePickerModel.defaultFontSize,
    this.fontColor = KenDatePickerModel.defaultFontColor,
    this.backColor = KenDatePickerModel.defaultBackColor,
    this.elevation = KenDatePickerModel.defaultElevation,
    this.captionFontBold = KenDatePickerModel.defaultCaptionFontBold,
    this.captionFontSize = KenDatePickerModel.defaultCaptionFontSize,
    this.captionFontColor = KenDatePickerModel.defaultCaptionFontColor,
    this.captionBackColor = KenDatePickerModel.defaultCaptionBackColor,
    this.underline = KenDatePickerModel.defaultUnderline,
    this.innerSpace = KenDatePickerModel.defaultInnerSpace,
    this.align = KenDatePickerModel.defaultAlign,
    this.valueField = KenDatePickerModel.defaultValueField,
    this.displayField = KenDatePickerModel.defaultdisplayedField,
    this.label = KenDatePickerModel.defaultLabel,
    this.width = KenDatePickerModel.defaultWidth,
    this.height = KenDatePickerModel.defaultHeight,
    this.padding = KenDatePickerModel.defaultPadding,
    this.showborder = KenDatePickerModel.defaultShowBorder,
    this.dashColor = KenDatePickerModel.defaultDashColor,
    this.clientValidator,
    this.clientOnSave,
    this.clientOnChange,
  }) : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    if (data != null && data!.value != null && data!.text == null) {
      data!.text = DateFormat("dd/MM/yyyy").format(data!.value!);
    }
  }

  @override
  runControllerActivities(KenModel model) {
    KenDatePickerModel m = model as KenDatePickerModel;
    id = m.id;
    type = m.type;
    title = m.title;
    valueField = m.valueField;
    displayField = m.displayedField;
    backColor = m.backColor;
    fontSize = m.fontSize;
    fontColor = m.fontColor;
    label = m.label;
    width = m.width;
    height = m.height;
    padding = m.padding;
    showborder = m.showBorder;
    elevation = m.elevation;
    borderRadius = m.borderRadius;
    borderWidth = m.borderWidth;
    borderColor = m.borderColor;
    fontBold = m.fontBold;
    underline = m.underline;
    align = m.align;
    innerSpace = m.innerSpace;
    captionFontBold = m.captionFontBold;
    captionFontSize = m.captionFontSize;
    captionFontColor = m.captionFontColor;
    captionBackColor = m.captionBackColor;
    dashColor = m.dashColor;

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenDatePickerModel m = model as KenDatePickerModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).isNotEmpty) {
      DateTime? value;
      String? text;
      if (workData['rows'][0][valueField] != null) {
        value = DateFormat('dd/MM/yyyy').parse(workData['rows'][0][valueField]);
      }
      if (workData['rows'][0][displayField] != null) {
        text = workData['rows'][0][displayField];
      }
      return KenDatePickerData(value: value, text: text);
    } else {
      return model.data;
    }
  }

  @override
  _KenDatePickerState createState() => _KenDatePickerState();
}

class _KenDatePickerState extends State<KenDatePicker>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenDatePickerModel? _model;
  KenDatePickerData? _data;

  @override
  void initState() {
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
    Widget datePicker = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return datePicker;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupDatePickerDao.getData(_model!);
        await _model!.getData();
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenDatePickerGetChildren,
      KenMessageBusEventData(
          context: context, widget: widget, model: _model, data: _data),
    );

    double? datePickerHeight = widget.height;
    double? datePickerWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (datePickerHeight == 0) {
        datePickerHeight = (_model!.parent as KenSectionModel).height;
      }
      if (datePickerWidth == 0) {
        datePickerWidth = (_model!.parent as KenSectionModel).width;
      }
    } else {
      if (datePickerHeight == 0) {
        datePickerHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
      if (datePickerWidth == 0) {
        datePickerWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    if (!widget.showborder!) {
      widget.borderColor = widget.borderColor;
    }

    ButtonStyle buttonStyle = _getButtonStyle();
    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();
    IconThemeData iconTheme = _getIconTheme();

    Widget icon = Container(
      color: iconTheme.color,
      padding: EdgeInsets.all(iconTheme.size!.toDouble() - 10),
      child: Icon(
        Icons.calendar_today,
        color: widget.fontColor,
        size: iconTheme.size,
      ),
    );

    var text = widget.label!.isEmpty
        ? Container()
        : Text(widget.label!, textAlign: TextAlign.center, style: captionStyle);

    var datepicker = KenDatePickerButton(
      widget.id,
      buttonStyle,
      textStyle,
      scaffoldKey: widget.scaffoldKey,
      formKey: widget.formKey,
      value: _data!.value,
      display: _data!.text,
      backColor: widget.backColor,
      fontSize: widget.fontSize,
      fontColor: widget.fontColor,
      label: widget.label,
      width: datePickerWidth,
      height: datePickerHeight,
      padding: widget.padding,
      showborder: widget.showborder,
      borderRadius: widget.borderRadius,
      borderWidth: widget.borderWidth,
      borderColor: widget.borderColor,
      fontBold: widget.fontBold,
      align: widget.align,
      underline: widget.underline,
      elevation: widget.elevation,
      captionFontBold: widget.captionFontBold,
      captionFontSize: widget.captionFontSize,
      captionFontColor: widget.captionFontColor,
      captionBackColor: widget.captionBackColor,
      clientOnChange: widget.clientOnChange,
      model: _model,
      globallyUniqueId: widget.globallyUniqueId,
      dashColor: widget.dashColor,
    );

    var line = widget.underline!
        ? KenLine(widget.scaffoldKey, widget.formKey)
        : Container();

    Widget children;

    if (widget.align == Alignment.centerLeft) {
      children = Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(width: widget.innerSpace),
            Expanded(
                child: Align(
                    alignment: widget.align!,
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: datepicker,
                        )),
                        icon,
                      ],
                    ))),
          ],
        ),
        line
      ]
          //color: widget.backColor,
          );
    } else if (widget.align == Alignment.centerRight) {
      children = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Align(
                alignment: widget.align!,
                child: Row(
                  children: [
                    icon,
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: datepicker,
                    )),
                  ],
                ),
              )),
              SizedBox(width: widget.innerSpace),
              text,
            ],
          ),
          line
        ],
        //color: widget.backColor,
      );
    } else if (widget.align == Alignment.topCenter) {
      children = SizedBox(
        height: datePickerHeight,
        width: datePickerWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: text,
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: datepicker,
                  )),
                  icon
                ],
              ),
            ),
            line
          ],
        ),
        //color: widget.backColor,
      );
    } else if (widget.align == Alignment.bottomCenter) {
      children = SizedBox(
        height: datePickerHeight,
        width: datePickerWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: datepicker,
                  )),
                  icon
                ],
              ),
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: text,
            )
          ],
        ),
        //color: widget.backColor,
      );
    } else // center
    {
      children = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          datepicker,
          SizedBox(width: widget.innerSpace),
          Expanded(child: text),
        ],
      );
    }

    return KenWidgetBuilderResponse(_model, children);
  }

  /// Extended theme

  ButtonStyle _getButtonStyle() {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color?>(widget.backColor),
      shape: MaterialStateProperty.all<OutlinedBorder?>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius!),
        ),
      ),
      side: MaterialStateProperty.all<BorderSide?>(
        BorderSide(
          width: widget.borderWidth!,
          color: widget.borderColor!,
        ),
      ),
      elevation: MaterialStateProperty.all<double?>(widget.elevation),
      padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
        const EdgeInsets.all(0),
      ),
    );
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold == true) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold == true) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData =
        IconThemeData(size: widget.fontSize, color: Colors.transparent);

    return themeData;
  }
}
