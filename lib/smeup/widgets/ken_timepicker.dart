// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/ken_utilities.dart';
import 'ken_line.dart';
import 'ken_timepicker_button.dart';

class KenTimePickerData {
  DateTime? time;
  String? formattedTime;

  KenTimePickerData({required this.time, this.formattedTime});
}

// ignore: must_be_immutable
class KenTimePicker extends StatelessWidget {
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
  List<String> minutesList;
  KenTimePickerData? data;
  Color? dashColor;

  // They have to be mapped with all the dynamisms
  // Function clientValidator;
  // Function clientOnSave;
  Function? clientOnChange;

  TextInputType? keyboard;
  double? parentWidth;
  double? parentHeight;

  KenTimePicker(
    this.scaffoldKey,
    this.formKey,
    this.data, {
    id = '',
    type = 'tpk',
    this.borderColor = KenTimepickerDefaults.defaultBorderColor,
    this.borderRadius = KenTimepickerDefaults.defaultBorderRadius,
    this.borderWidth = KenTimepickerDefaults.defaultBorderWidth,
    this.fontBold = KenTimepickerDefaults.defaultFontBold,
    this.fontSize = KenTimepickerDefaults.defaultFontSize,
    this.fontColor = KenTimepickerDefaults.defaultFontColor,
    this.backColor = KenTimepickerDefaults.defaultBackColor,
    this.elevation = KenTimepickerDefaults.defaultElevation,
    this.captionFontBold = KenTimepickerDefaults.defaultCaptionFontBold,
    this.captionFontSize = KenTimepickerDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenTimepickerDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenTimepickerDefaults.defaultCaptionBackColor,
    this.underline = KenTimepickerDefaults.defaultUnderline,
    this.innerSpace = KenTimepickerDefaults.defaultInnerSpace,
    this.align = KenTimepickerDefaults.defaultAlign,
    this.label = KenTimepickerDefaults.defaultLabel,
    this.width = KenTimepickerDefaults.defaultWidth,
    this.height = KenTimepickerDefaults.defaultHeight,
    this.padding = KenTimepickerDefaults.defaultPadding,
    this.showborder = KenTimepickerDefaults.defaultShowBorder,
    this.minutesList = KenTimepickerDefaults.defaultMinutesList,
    this.dashColor = KenTimepickerDefaults.defaultDashColor,
    // They have to be mapped with all the dynamisms
    //this.clientValidator,
    //this.clientOnSave,
    this.clientOnChange,
    this.keyboard,
    this.parentWidth,
    this.parentHeight,
  });

  @override
  Widget build(BuildContext context) {
    double? timePickerHeight = height;
    double? timePickerWidth = width;
    if (parentHeight != null && parentWidth != null) {
      if (timePickerHeight == 0) {
        timePickerHeight = parentHeight;
      }
      if (timePickerWidth == 0) {
        timePickerWidth = parentWidth;
      }
    } else {
      if (timePickerHeight == 0) {
        timePickerHeight = KenUtilities.getDeviceInfo().safeHeight;
      }
      if (timePickerWidth == 0) {
        timePickerWidth = KenUtilities.getDeviceInfo().safeWidth;
      }
    }

    if (!showborder!) {
      borderColor = borderColor;
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
        color: fontColor,
        size: iconTheme.size,
      ),
    );

    var text = label!.isEmpty
        ? Container()
        : Text(label!, textAlign: TextAlign.center, style: captionStyle);

    Widget timepicker = KenTimePickerButton(
      data,
      buttonStyle,
      textStyle,
      scaffoldKey: scaffoldKey,
      formKey: formKey,
      id: id,
      backColor: backColor,
      fontSize: fontSize,
      fontColor: fontColor,
      borderRadius: borderRadius,
      borderWidth: borderWidth,
      borderColor: borderColor,
      fontBold: fontBold,
      align: align,
      underline: underline,
      elevation: elevation,
      captionFontBold: captionFontBold,
      captionFontSize: captionFontSize,
      captionFontColor: captionFontColor,
      captionBackColor: captionBackColor,
      label: label,
      width: timePickerWidth,
      height: timePickerHeight,
      padding: padding,
      showborder: showborder,
      minutesList: minutesList,
      clientOnChange: clientOnChange,
      dashColor: dashColor,
    );

    var line = underline! ? KenLine(scaffoldKey, formKey) : Container();

    Widget children;

    if (align == Alignment.centerLeft) {
      children = Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            text,
            SizedBox(width: innerSpace),
            Expanded(
                child: Align(
                    alignment: align!,
                    child: Row(
                      children: [
                        Expanded(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: timepicker,
                        )),
                        icon,
                      ],
                    ))),
          ],
        ),
        line
      ]
          //color: backColor,
          );
    } else if (align == Alignment.centerRight) {
      children = Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Align(
                alignment: align!,
                child: Row(
                  children: [
                    icon,
                    Expanded(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: timepicker,
                    )),
                  ],
                ),
              )),
              SizedBox(width: innerSpace),
              text,
            ],
          ),
          line
        ],
        //color: backColor,
      );
    } else if (align == Alignment.topCenter) {
      children = SizedBox(
        height: height,
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: text,
            ),
            SizedBox(height: innerSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Expanded(
                      child: Align(
                    alignment: Alignment.centerLeft,
                    child: timepicker,
                  )),
                  icon
                ],
              ),
            ),
            line
          ],
        ),
        //color: backColor,
      );
    } else if (align == Alignment.bottomCenter) {
      children = SizedBox(
        height: height,
        width: width,
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
                    child: timepicker,
                  )),
                  icon
                ],
              ),
            ),
            SizedBox(height: innerSpace),
            Align(
              alignment: Alignment.centerLeft,
              child: text,
            ),
            line
          ],
        ),
        //color: backColor,
      );
    } else // center
    {
      children = Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          timepicker,
          SizedBox(width: innerSpace),
          Expanded(child: text),
        ],
      );
    }
    return children;
  }

  ButtonStyle _getButtonStyle() {
    var timePickerTheme = TimePickerThemeData(
        backgroundColor: backColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!)),
        dayPeriodBorderSide:
            BorderSide(width: borderWidth!, color: borderColor!));

    var elevatedButtonStyle = ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all<Color?>(timePickerTheme.backgroundColor),
        elevation: MaterialStateProperty.all<double?>(elevation),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
            const EdgeInsets.all(0)),
        shape: MaterialStateProperty.all<OutlinedBorder?>(
            timePickerTheme.shape as OutlinedBorder?),
        side: MaterialStateProperty.all<BorderSide?>(
            timePickerTheme.dayPeriodBorderSide));

    return elevatedButtonStyle;
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: fontColor, fontSize: fontSize, backgroundColor: backColor);

    if (fontBold!) {
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
    TextStyle style =
        TextStyle(color: captionFontColor, fontSize: captionFontSize);

    if (captionFontBold!) {
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
        IconThemeData(size: fontSize, color: Colors.transparent);

    return themeData;
  }
}
