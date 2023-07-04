import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datepicker;
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/widgets/ken_datepicker_model.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenTimepicker.dart';

// ignore: must_be_immutable
class KenDatePickerButton extends StatefulWidget {
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

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
  KenDatePickerModel? model;
  final Function? clientOnChange;
  Function(dynamic, KenCallbackType, dynamic)? callBack;

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

  KenDatePickerButton(this.id, this.buttonStyle, this.textStyle,
      {this.scaffoldKey,
      this.formKey,
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
      this.underline = KenDatePickerModel.defaultUnderline,
      this.align = KenDatePickerModel.defaultAlign,
      this.label = KenDatePickerModel.defaultLabel,
      this.width = KenDatePickerModel.defaultWidth,
      this.height = KenDatePickerModel.defaultHeight,
      this.padding = KenDatePickerModel.defaultPadding,
      this.showborder = KenDatePickerModel.defaultShowBorder,
      this.clientOnChange,
      this.model,
      this.callBack}) {
    KenDatePickerModel.setDefaults(this);
  }

  @override
  _KenDatePickerButtonState createState() => _KenDatePickerButtonState();
}

class _KenDatePickerButtonState extends State<KenDatePickerButton> {
  DateTime? _currentValue;
  String? _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.value;
    _currentDisplay = widget.display;

    if (widget.callBack != null) {
      widget.callBack!(widget, KenCallbackType.initState, null);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = Container(
      height: 20,
      width: widget.width,
      padding: widget.padding,
      child: ElevatedButton(
          style: widget.buttonStyle,
          onPressed: () {
            datepicker.DatePicker.showDatePicker(context,
                theme: datepicker.DatePickerTheme(
                  backgroundColor: widget.backColor!,
                  // headerColor: widget.textStyle.backgroundColor,
                  // doneStyle: widget.textStyle,
                  // cancelStyle: widget.textStyle,
                  // itemStyle: widget.textStyle
                ),
                currentTime: _currentValue,
                showTitleActions: true, onConfirm: (date) {
              setState(() {
                final newTime = DateFormat('dd/MM/yyyy').format(date);
                _currentDisplay = newTime;
                _currentValue = date;

                if (widget.callBack != null) {
                  widget.callBack!(widget, KenCallbackType.onPressed, newTime);
                }

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
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(_currentDisplay!, style: widget.textStyle),
            ),
          )),
    );

    return button;
  }
}
