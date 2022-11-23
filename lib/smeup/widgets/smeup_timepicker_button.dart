import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:ken/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/widgets/smeup_timepicker.dart';
import 'package:ken/smeup/widgets/smeup_timepicker_customization.dart';

import '../services/smeup_dynamism_service.dart';

// ignore: must_be_immutable
class SmeupTimePickerButton extends StatefulWidget {
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
  SmeupTimePickerModel? model;

  final String? id;

  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final Alignment? align;
  final List<String>? minutesList;
  final SmeupTimePickerData? data;
  final Function? clientOnChange;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  SmeupTimePickerButton(
    this.data,
    this.buttonStyle,
    this.textStyle, {
    this.scaffoldKey,
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
    this.underline = SmeupTimePickerModel.defaultUnderline,
    this.align = SmeupTimePickerModel.defaultAlign,
    this.label = SmeupTimePickerModel.defaultLabel,
    this.width = SmeupTimePickerModel.defaultWidth,
    this.height = SmeupTimePickerModel.defaultHeight,
    this.padding = SmeupTimePickerModel.defaultPadding,
    this.showborder = SmeupTimePickerModel.defaultShowBorder,
    this.minutesList,
    this.clientOnChange,
    this.model,
  }) {
    SmeupTimePickerModel.setDefaults(this);
  }

  @override
  _SmeupTimePickerButtonState createState() => _SmeupTimePickerButtonState();
}

class _SmeupTimePickerButtonState extends State<SmeupTimePickerButton> {
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
              DatePicker.showPicker(context,
                  theme: DatePickerTheme(
                      backgroundColor: widget.backColor!,
                      headerColor: widget.textStyle.backgroundColor,
                      doneStyle: widget.textStyle,
                      cancelStyle: widget.textStyle,
                      itemStyle: widget.textStyle),
                  pickerModel: SmeupTimePickerCustomization(
                      currentTime: _currentValue,
                      showSecondsColumn: false,
                      minutesList: widget.minutesList),
                  showTitleActions: true, onConfirm: (date) {
                setState(() {
                  final newTime = DateFormat('HH:mm').format(date);
                  _currentDisplay = newTime;
                  _currentValue = date;
                  SmeupVariablesService.setVariable(widget.id, newTime,
                      formKey: widget.formKey);

                  if (widget.clientOnChange != null) {
                    widget.clientOnChange!(SmeupTimePickerData(
                      time: _currentValue,
                      formattedTime: _currentDisplay,
                    ));
                  }

                  if (widget.model != null) {
                    SmeupDynamismService.run(widget.model!.dynamisms, context,
                        'change', widget.scaffoldKey!, widget.formKey);
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
