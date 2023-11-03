// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../services/ken_defaults.dart';
import 'ken_datepicker_button.dart';
import 'ken_line.dart';

class KenDatePickerData {
  DateTime? value;
  String? text;
  KenDatePickerData({required this.value, this.text});
}

class KenDatePicker extends StatefulWidget {
  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final bool? fontBold;
  final double? fontSize;
  final Color? fontColor;
  final Color? backColor;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final bool? underline;
  final double? innerSpace;
  final Alignment? align;
  final KenDatePickerData? data;
  final String? title;
  final String? id;
  final String? type;
  final String? valueField;
  final String? displayField;
  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final double? elevation;
  final Color? dashColor;

  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  //Functions
  final Function? clientValidator;

  KenDatePicker(
    this.data, {
    super.key,
    this.id = '',
    this.type = 'cal',
    this.title = '',
    this.borderColor = KenDatepickerDefaults.defaultBorderColor,
    this.borderWidth = KenDatepickerDefaults.defaultBorderWidth,
    this.borderRadius = KenDatepickerDefaults.defaultBorderRadius,
    this.fontBold = KenDatepickerDefaults.defaultFontBold,
    this.fontSize = KenDatepickerDefaults.defaultFontSize,
    this.fontColor = KenDatepickerDefaults.defaultFontColor,
    this.backColor = KenDatepickerDefaults.defaultBackColor,
    this.elevation = KenDatepickerDefaults.defaultElevation,
    this.captionFontBold = KenDatepickerDefaults.defaultCaptionFontBold,
    this.captionFontSize = KenDatepickerDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenDatepickerDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenDatepickerDefaults.defaultCaptionBackColor,
    this.underline = KenDatepickerDefaults.defaultUnderline,
    this.innerSpace = KenDatepickerDefaults.defaultInnerSpace,
    this.align = KenDatepickerDefaults.defaultAlign,
    this.valueField = KenDatepickerDefaults.defaultValueField,
    this.displayField = KenDatepickerDefaults.defaultdisplayedField,
    this.label = KenDatepickerDefaults.defaultLabel,
    this.width = KenDatepickerDefaults.defaultWidth,
    this.height = KenDatepickerDefaults.defaultHeight,
    this.padding = KenDatepickerDefaults.defaultPadding,
    this.showborder = KenDatepickerDefaults.defaultShowBorder,
    this.dashColor = KenDatepickerDefaults.defaultDashColor,
    this.clientValidator,
    this.scaffoldKey,
    this.formKey,
  }) {
    if (data != null && data!.value != null && data!.text == null) {
      data!.text = DateFormat("dd/MM/yyyy").format(data!.value!);
    }
  }

  @override
  KenDatePickerState createState() => KenDatePickerState();
}

class KenDatePickerState extends State<KenDatePicker> {
  KenDatePickerData? _data;

  @override
  void initState() {
    _data = widget.data;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
      value: _data!.value,
      display: _data!.text,
      backColor: widget.backColor,
      fontSize: widget.fontSize,
      fontColor: widget.fontColor,
      label: widget.label,
      height: widget.height,
      width: widget.width,
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
      dashColor: widget.dashColor,
      scaffoldKey: widget.scaffoldKey,
      formKey: widget.formKey,
    );

    var line = widget.underline! ? const KenLine() : Container();

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
        height: widget.height,
        width: widget.width,
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
        height: widget.height,
        width: widget.width,
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

    return children;
  }

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

    if (widget.fontBold!) {
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

    if (widget.captionFontBold!) {
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
