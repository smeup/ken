import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_datepicker_model.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenDatepickerButton.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenLine.dart';
import 'package:ken/smeup/widgets/kenWidgetInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetMixin.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';

import '../services/ken_configuration_service.dart';

class KenDatePickerData {
  DateTime? value;
  String? text;
  KenDatePickerData({required this.value, this.text});
}

// ignore: must_be_immutable
class SmeupDatePicker extends StatefulWidget
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

  //Functions
  Function? clientValidator;
  Function? clientOnSave;
  Function? clientOnChange;

  Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  SmeupDatePicker.withController(KenDatePickerModel this.model,
      this.scaffoldKey, this.formKey, this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  SmeupDatePicker(this.scaffoldKey, this.formKey, this.data,
      {this.id = '',
      this.type = 'cal',
      this.title = '',
      this.borderColor,
      this.borderRadius,
      this.borderWidth,
      this.fontBold,
      this.fontSize,
      this.fontColor,
      this.backColor,
      this.elevation,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
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
      this.clientValidator,
      this.clientOnSave,
      this.clientOnChange,
      this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenDatePickerModel.setDefaults(this);
    if (data != null && data!.value != null && data!.text == null) {
      data!.text = DateFormat("dd/MM/yyyy").format(data!.value!);
    }
  }

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

    data = treatData(m);
  }

  @override
  dynamic treatData(KenModel model) {
    KenDatePickerModel m = model as KenDatePickerModel;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).length > 0) {
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
  _SmeupDatePickerState createState() => _SmeupDatePickerState();
}

class _SmeupDatePickerState extends State<SmeupDatePicker>
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

  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupDatePickerDao.getData(_model!);
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.getChildren, _data, null);
    }

    double? datePickerHeight = widget.height;
    double? datePickerWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (datePickerHeight == 0)
        datePickerHeight = (_model!.parent as KenSectionModel).height;
      if (datePickerWidth == 0)
        datePickerWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (datePickerHeight == 0)
        datePickerHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (datePickerWidth == 0)
        datePickerWidth = KenUtilities.getDeviceInfo().safeWidth;
    }

    if (!widget.showborder!) {
      widget.borderColor =
          KenConfigurationService.getTheme()!.scaffoldBackgroundColor;
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
        color: Theme.of(context).primaryColor,
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
    );

    var line = widget.underline!
        ? KenLine(widget.scaffoldKey, widget.formKey)
        : Container();

    var children;

    if (widget.align == Alignment.centerLeft) {
      children = Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(width: widget.innerSpace),
            Expanded(
                child: Align(
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                          child: datepicker,
                          alignment: Alignment.centerLeft,
                        )),
                        icon,
                      ],
                    ),
                    alignment: widget.align!)),
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
                child: Row(
                  children: [
                    icon,
                    Expanded(
                        child: Align(
                      child: datepicker,
                      alignment: Alignment.centerLeft,
                    )),
                  ],
                ),
                alignment: widget.align!,
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
      children = Container(
        height: datePickerHeight,
        width: datePickerWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: text,
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    child: datepicker,
                    alignment: Alignment.centerLeft,
                  )),
                  icon
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            line
          ],
        ),
        //color: widget.backColor,
      );
    } else if (widget.align == Alignment.bottomCenter) {
      children = Container(
        height: datePickerHeight,
        width: datePickerWidth,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    child: datepicker,
                    alignment: Alignment.centerLeft,
                  )),
                  icon
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            SizedBox(height: widget.innerSpace),
            Align(
              child: text,
              alignment: Alignment.centerLeft,
            )
          ],
        ),
        //color: widget.backColor,
      );
    } else // center
    {
      children = Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            datepicker,
            SizedBox(width: widget.innerSpace),
            Expanded(child: text),
          ],
        ),
      );
    }

    return KenWidgetBuilderResponse(_model, children);
  }

  ButtonStyle _getButtonStyle() {
    var timePickerTheme = KenConfigurationService.getTheme()!
        .timePickerTheme
        .copyWith(
            backgroundColor: widget.backColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius!)),
            dayPeriodBorderSide: BorderSide(
                width: widget.borderWidth!, color: widget.borderColor!));

    var elevatedButtonStyle = KenConfigurationService.getTheme()!
        .elevatedButtonTheme
        .style!
        .copyWith(
            backgroundColor: MaterialStateProperty.all<Color?>(
                timePickerTheme.backgroundColor),
            elevation: MaterialStateProperty.all<double?>(widget.elevation),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<OutlinedBorder?>(
                timePickerTheme.shape as OutlinedBorder?),
            side: MaterialStateProperty.all<BorderSide?>(
                timePickerTheme.dayPeriodBorderSide));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.bodyText1!;

    style = style.copyWith(color: widget.fontColor, fontSize: widget.fontSize);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = KenConfigurationService.getTheme()!.textTheme.caption!;

    style = style.copyWith(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(size: widget.fontSize);

    return themeData;
  }
}
