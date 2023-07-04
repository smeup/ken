import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datepicker;
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/widgets/ken_timepicker_model.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import 'package:ken/smeup/widgets/kenTimepicker.dart';
import 'package:ken/smeup/widgets/kenTimepickerCustomization.dart';

// ignore: must_be_immutable
class KenTimePickerButton extends StatefulWidget {
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
  KenTimePickerModel? model;

  final String? id;

  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final Alignment? align;
  final List<String>? minutesList;
  final KenTimePickerData? data;
  final Function? clientOnChange;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  Function(dynamic, KenCallbackType, dynamic)? callBack;

  KenTimePickerButton(this.data, this.buttonStyle, this.textStyle,
      {this.scaffoldKey,
      this.formKey,
      this.id = '',
      this.backColor,
      this.fontSize,
      this.fontColor,
      this.borderColor,
      this.borderWidth,
      this.borderRadius,
      this.fontBold,
      this.elevation,
      this.captionFontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.underline = KenTimePickerModel.defaultUnderline,
      this.align = KenTimePickerModel.defaultAlign,
      this.label = KenTimePickerModel.defaultLabel,
      this.width = KenTimePickerModel.defaultWidth,
      this.height = KenTimePickerModel.defaultHeight,
      this.padding = KenTimePickerModel.defaultPadding,
      this.showborder = KenTimePickerModel.defaultShowBorder,
      this.minutesList,
      this.clientOnChange,
      this.model,
      this.callBack}) {
    KenTimePickerModel.setDefaults(this);
  }

  @override
  _KenTimePickerButtonState createState() => _KenTimePickerButtonState();
}

class _KenTimePickerButtonState extends State<KenTimePickerButton> {
  DateTime? _currentValue;
  String? _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.data!.time;
    _currentDisplay = widget.data!.formattedTime;
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
              datepicker.DatePicker.showPicker(context,
                  theme: datepicker.DatePickerTheme(
                    backgroundColor: widget.backColor!,
                    // headerColor: widget.textStyle.backgroundColor,
                    // doneStyle: widget.textStyle,
                    // cancelStyle: widget.textStyle,
                    // itemStyle: widget.textStyle
                  ),
                  pickerModel: KenTimePickerCustomization(
                      currentTime: _currentValue,
                      showSecondsColumn: false,
                      minutesList: widget.minutesList),
                  showTitleActions: true, onConfirm: (date) {
                setState(() {
                  final newTime = DateFormat('HH:mm').format(date);
                  _currentDisplay = newTime;
                  _currentValue = date;

                  if (widget.callBack != null) {
                    widget.callBack!(
                        widget, KenCallbackType.onPressed, newTime);
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
            )));

    return button;
  }
}
