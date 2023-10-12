import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datepicker;
import 'package:intl/intl.dart';
import 'ken_timepicker.dart';

// ignore: must_be_immutable
class KenDatePickerButton extends StatefulWidget {
  Color? borderColor;
  double? borderWidth;
  double? borderRadius;
  bool? fontBold;
  double? fontSize;
  Color? fontColor;
  Color? backColor;
  double? elevation;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;
  bool? underline;
  final Function? clientOnChange;
  Color? dashColor;

  final DateTime? value;
  final String? id;
  final String? display;
  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final Alignment? align;

  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  KenDatePickerButton(
    this.id,
    this.buttonStyle,
    this.textStyle, {
    super.key,
    this.value,
    this.display,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontBold,
    this.fontSize,
    this.fontColor,
    this.backColor,
    this.elevation,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.captionBackColor,
    this.underline,
    this.align,
    this.label,
    this.width,
    this.height,
    this.padding,
    this.showborder,
    this.clientOnChange,
    this.dashColor,
  });

  @override
  KenDatePickerButtonState createState() => KenDatePickerButtonState();
}

class KenDatePickerButtonState extends State<KenDatePickerButton> {
  DateTime? _currentValue;
  String? _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.value;
    _currentDisplay = widget.display;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = Padding(
      padding: widget.padding!,
      child: SizedBox(
        height: 40,
        width: widget.width,
        child: ElevatedButton(
            style: widget.buttonStyle,
            onPressed: () {
              datepicker.DatePicker.showDatePicker(context,
                  theme: datepicker.DatePickerTheme(
                      backgroundColor: widget.dashColor!,
                      // headerColor: widget.textStyle.backgroundColor,
                      doneStyle: widget.textStyle,
                      cancelStyle: widget.textStyle,
                      itemStyle: widget.textStyle),
                  currentTime: _currentValue,
                  showTitleActions: true, onConfirm: (date) {
                setState(() {
                  final newDate = DateFormat('dd/MM/yyyy').format(date);
                  _currentDisplay = newDate;
                  _currentValue = date;

                  if (widget.clientOnChange != null) {
                    widget.clientOnChange!(KenTimePickerData(
                      time: _currentValue,
                      formattedTime: _currentDisplay,
                    ));
                  }
                });
              });
            },
            child: Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(_currentDisplay!, style: widget.textStyle),
              ),
            )),
      ),
    );

    return button;
  }
}
