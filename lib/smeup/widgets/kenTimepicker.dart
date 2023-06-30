import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/ken_widget_builder_response.dart';
import 'package:ken/smeup/models/widgets/ken_model.dart';
import 'package:ken/smeup/models/widgets/ken_section_model.dart';
import 'package:ken/smeup/models/widgets/ken_timepicker_model.dart';
import 'package:ken/smeup/services/ken_utilities.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenLine.dart';
import 'package:ken/smeup/widgets/kenTimepickerButton.dart';
import 'package:ken/smeup/widgets/kenWidgetStateInterface.dart';
import 'package:ken/smeup/widgets/kenWidgetStateMixin.dart';
import '../services/ken_configuration_service.dart';
import 'kenWidgetInterface.dart';
import 'kenWidgetMixin.dart';

class KenTimePickerData {
  DateTime? time;
  String? formattedTime;

  KenTimePickerData({required this.time, this.formattedTime});
}

// ignore: must_be_immutable
class KenTimePicker extends StatefulWidget
    with KenWidgetMixin
    implements KenWidgetInterface {
  KenTimePickerModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  String? id;
  String? type;
  Color? backColor;
  double? fontSize;
  Color? fontColor;
  String? label;
  double? width;
  double? height;
  EdgeInsetsGeometry? padding;
  bool? showborder;
  String? valueField;
  String? displayField;
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? underline;
  double? innerSpace;
  Alignment? align;
  String? title;
  double? elevation;
  List<String>? minutesList;
  KenTimePickerData? data;

  // They have to be mapped with all the dynamisms
  // Function clientValidator;
  // Function clientOnSave;
  Function? clientOnChange;

  TextInputType? keyboard;

  Function(Widget, KenCallbackType, dynamic, dynamic)? callBack;

  KenTimePicker(this.scaffoldKey, this.formKey, this.data,
      {id = '',
      type = 'tpk',
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
      this.underline = KenTimePickerModel.defaultUnderline,
      this.innerSpace = KenTimePickerModel.defaultInnerSpace,
      this.align = KenTimePickerModel.defaultAlign,
      this.label = KenTimePickerModel.defaultLabel,
      this.width = KenTimePickerModel.defaultWidth,
      this.height = KenTimePickerModel.defaultHeight,
      this.padding = KenTimePickerModel.defaultPadding,
      this.showborder = KenTimePickerModel.defaultShowBorder,
      this.minutesList,
      // They have to be mapped with all the dynamisms
      //this.clientValidator,
      //this.clientOnSave,
      this.clientOnChange,
      this.keyboard,
      this.callBack})
      : super(key: Key(KenUtilities.getWidgetId(type, id))) {
    id = KenUtilities.getWidgetId(type, id);
    KenTimePickerModel.setDefaults(this);
    if (minutesList == null)
      this.minutesList = KenTimePickerModel.defaultMinutesList;
  }

  KenTimePicker.withController(KenTimePickerModel this.model, this.scaffoldKey,
      this.formKey, this.callBack)
      : super(key: Key(KenUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model!);
  }

  @override
  runControllerActivities(KenModel model) {
    KenTimePickerModel m = model as KenTimePickerModel;
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
    minutesList = m.minutesList;
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
    // change data format
    final workData = formatDataFields(model);

    String? display;
    DateTime value;

    final now = DateTime.now();

    if (workData != null) {
      final valueString = workData['rows'][0][valueField];
      final split = valueString.split(':');
      value = DateTime.parse(
          '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${split[0]}:${split[1]}:00');

      display = workData['rows'][0][displayField];
    } else {
      value = now;
      display = DateFormat('HH:mm').format(value);
    }

    return KenTimePickerData(time: value, formattedTime: display);
  }

  @override
  _KenTimePickerState createState() => _KenTimePickerState();
}

class _KenTimePickerState extends State<KenTimePicker>
    with KenWidgetStateMixin
    implements KenWidgetStateInterface {
  KenTimePickerModel? _model;
  KenTimePickerData? _data;

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
    Widget timePicker = runBuild(context, widget.id, widget.type,
        widget.scaffoldKey, getInitialdataLoaded(_model), notifierFunction: () {
      setState(() {
        widgetLoadType = LoadType.Immediate;
        setDataLoad(widget.id, false);
      });
    });

    return timePicker;
  }

  @override
  Future<KenWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id)! && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        // await SmeupTimePickerDao.getData(_model!);
        await _model!.getData(_model!.instanceCallBack);
        _data = widget.treatData(_model!);
      }
      setDataLoad(widget.id, true);
    }

    Widget timepicker;

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.getChildren, _data, null);
    }

    double? timePickerHeight = widget.height;
    double? timePickerWidth = widget.width;
    if (_model != null && _model!.parent != null) {
      if (timePickerHeight == 0)
        timePickerHeight = (_model!.parent as KenSectionModel).height;
      if (timePickerWidth == 0)
        timePickerWidth = (_model!.parent as KenSectionModel).width;
    } else {
      if (timePickerHeight == 0)
        timePickerHeight = KenUtilities.getDeviceInfo().safeHeight;
      if (timePickerWidth == 0)
        timePickerWidth = KenUtilities.getDeviceInfo().safeWidth;
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
        Icons.access_time,
        color: Theme.of(context).primaryColor,
        size: iconTheme.size,
      ),
    );

    var text = widget.label!.isEmpty
        ? Container()
        : Text(widget.label!, textAlign: TextAlign.center, style: captionStyle);

    timepicker = KenTimePickerButton(
      _data,
      buttonStyle,
      textStyle,
      scaffoldKey: widget.scaffoldKey,
      formKey: widget.formKey,
      id: widget.id,
      backColor: widget.backColor,
      fontSize: widget.fontSize,
      fontColor: widget.fontColor,
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
      label: widget.label,
      width: timePickerWidth,
      height: timePickerHeight,
      padding: widget.padding,
      showborder: widget.showborder,
      minutesList: widget.minutesList,
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
                          child: timepicker,
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
                      child: timepicker,
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
        height: widget.height,
        width: widget.width,
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
                    child: timepicker,
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
        height: widget.height,
        width: widget.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    child: timepicker,
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
            ),
            line
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
            timepicker,
            SizedBox(width: widget.innerSpace),
            Expanded(child: text),
          ],
        ),
        //color: widget.backColor,
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
