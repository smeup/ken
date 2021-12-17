import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/daos/smeup_datepicker_dao.dart';
import 'package:mobile_components_library/smeup/models/smeupWidgetBuilderResponse.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_section_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_utilities.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_datepicker_button.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_line.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_mixin.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_interface.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_widget_state_mixin.dart';

class SmeupDatePickerData {
  DateTime value;
  String text;
  SmeupDatePickerData({@required this.value, this.text});
}

// ignore: must_be_immutable
class SmeupDatePicker extends StatefulWidget
    with SmeupWidgetMixin
    implements SmeupWidgetInterface {
  SmeupDatePickerModel model;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  Color borderColor;
  double borderWidth;
  double borderRadius;
  bool fontBold;
  double fontSize;
  Color fontColor;
  Color backColor;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;
  bool underline;
  double innerSpace;
  Alignment align;
  SmeupDatePickerData data;
  String title;
  String id;
  String type;
  String valueField;
  String displayField;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  double elevation;

  //Functions
  Function clientValidator;
  Function clientOnSave;
  Function clientOnChange;

  SmeupDatePicker.withController(
    this.model,
    this.scaffoldKey,
    this.formKey,
  ) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
    runControllerActivities(model);
  }

  SmeupDatePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    this.id = '',
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
    this.underline = SmeupDatePickerModel.defaultUnderline,
    this.innerSpace = SmeupDatePickerModel.defaultInnerSpace,
    this.align = SmeupDatePickerModel.defaultAlign,
    this.valueField = SmeupDatePickerModel.defaultValueField,
    this.displayField = SmeupDatePickerModel.defaultdisplayedField,
    this.label = SmeupDatePickerModel.defaultLabel,
    this.width = SmeupDatePickerModel.defaultWidth,
    this.height = SmeupDatePickerModel.defaultHeight,
    this.padding = SmeupDatePickerModel.defaultPadding,
    this.showborder = SmeupDatePickerModel.defaultShowBorder,
    this.clientValidator,
    this.clientOnSave,
    this.clientOnChange,
  }) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
    id = SmeupUtilities.getWidgetId(type, id);
    SmeupDatePickerModel.setDefaults(this);
    if (data != null && data.value != null && data.text == null) {
      data.text = DateFormat("dd/MM/yyyy").format(data.value);
    }
  }

  runControllerActivities(SmeupModel model) {
    SmeupDatePickerModel m = model;
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
  dynamic treatData(SmeupModel model) {
    SmeupDatePickerModel m = model;

    // change data format
    var workData = formatDataFields(m);

    // set the widget data
    if (workData != null && (workData['rows'] as List).length > 0) {
      DateTime value;
      String text;
      if (workData['rows'][0][valueField] != null) {
        value = DateFormat('dd/MM/yyyy').parse(workData['rows'][0][valueField]);
      }
      if (workData['rows'][0][displayField] != null) {
        text = workData['rows'][0][displayField];
      }
      return SmeupDatePickerData(value: value, text: text);
    } else {
      return model.data;
    }
  }

  @override
  _SmeupDatePickerState createState() => _SmeupDatePickerState();
}

class _SmeupDatePickerState extends State<SmeupDatePicker>
    with SmeupWidgetStateMixin
    implements SmeupWidgetStateInterface {
  SmeupDatePickerModel _model;
  SmeupDatePickerData _data;

  @override
  void initState() {
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

  Future<SmeupWidgetBuilderResponse> getChildren() async {
    if (!getDataLoaded(widget.id) && widgetLoadType != LoadType.Delay) {
      if (_model != null) {
        await SmeupDatePickerDao.getData(_model);
        _data = widget.treatData(_model);
      }
      setDataLoad(widget.id, true);
    }

    if (_data == null) {
      return getFunErrorResponse(context, _model);
    }

    SmeupVariablesService.setVariable(
        widget.id, DateFormat("yyyyMMdd").format(_data.value));

    double datePickerHeight = widget.height;
    double datePickerWidth = widget.width;
    if (_model != null && _model.parent != null) {
      if (datePickerHeight == 0)
        datePickerHeight = (_model.parent as SmeupSectionModel).height;
      if (datePickerWidth == 0)
        datePickerWidth = (_model.parent as SmeupSectionModel).width;
    } else {
      if (datePickerHeight == 0)
        datePickerHeight = MediaQuery.of(context).size.height;
      if (datePickerWidth == 0)
        datePickerWidth = MediaQuery.of(context).size.width;
    }

    if (!widget.showborder) {
      widget.borderColor =
          SmeupConfigurationService.getTheme().scaffoldBackgroundColor;
    }

    ButtonStyle buttonStyle = _getButtonStyle();
    TextStyle textStyle = _getTextStile();
    TextStyle captionStyle = _getCaptionStile();

    var text = widget.label.isEmpty
        ? Container()
        : Text(widget.label, textAlign: TextAlign.center, style: captionStyle);

    var datepicker = SmeupDatePickerButton(widget.id, buttonStyle, textStyle,
        scaffoldKey: widget.scaffoldKey,
        formKey: widget.formKey,
        value: _data.value,
        display: _data.text,
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
        captionBackColor: widget.captionBackColor);

    var line = widget.underline
        ? SmeupLine(widget.scaffoldKey, widget.formKey)
        : Container();

    var children;

    if (widget.align == Alignment.centerLeft) {
      children = Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(width: widget.innerSpace),
            Expanded(child: Align(child: datepicker, alignment: widget.align)),
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
                child: datepicker,
                alignment: widget.align,
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
              child: datepicker,
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
              child: datepicker,
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
            datepicker,
            SizedBox(width: widget.innerSpace),
            Expanded(child: text),
          ],
        ),
        //color: widget.backColor,
      );
    }

// SizedBox(
//         height: widget.height,
//         width: widget.width,
//         child:
    return SmeupWidgetBuilderResponse(_model, children);
  }

  ButtonStyle _getButtonStyle() {
    var timePickerTheme = SmeupConfigurationService.getTheme()
        .timePickerTheme
        .copyWith(
            backgroundColor: widget.backColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.borderRadius)),
            dayPeriodBorderSide: BorderSide(
                width: widget.borderWidth, color: widget.borderColor));

    var elevatedButtonStyle = SmeupConfigurationService.getTheme()
        .elevatedButtonTheme
        .style
        .copyWith(
            backgroundColor: MaterialStateProperty.all<Color>(
                timePickerTheme.backgroundColor),
            elevation: MaterialStateProperty.all<double>(widget.elevation),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.all(0)),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                timePickerTheme.shape),
            side: MaterialStateProperty.all<BorderSide>(
                timePickerTheme.dayPeriodBorderSide));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.bodyText1;

    style = style.copyWith(color: widget.fontColor, fontSize: widget.fontSize);

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  TextStyle _getCaptionStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.caption;

    style = style.copyWith(
        color: widget.captionFontColor, fontSize: widget.captionFontSize);

    if (widget.captionFontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
