import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';

// ignore: must_be_immutable
class SmeupDatePickerButton extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  Color borderColor;
  double borderWidth;
  double borderRadius;
  bool fontBold;
  double fontSize;
  Color fontColor;
  Color backColor;
  double elevation;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;

  final bool underline;
  final DateTime value;
  final String id;
  final String display;
  final String label;
  final double width;
  final double height;
  final EdgeInsetsGeometry padding;
  final bool showborder;
  final Alignment align;

  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  SmeupDatePickerButton(
    this.id,
    this.buttonStyle,
    this.textStyle, {
    this.scaffoldKey,
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
    this.underline = SmeupDatePickerModel.defaultUnderline,
    this.align = SmeupDatePickerModel.defaultAlign,
    this.label = SmeupDatePickerModel.defaultLabel,
    this.width = SmeupDatePickerModel.defaultWidth,
    this.height = SmeupDatePickerModel.defaultHeight,
    this.padding = SmeupDatePickerModel.defaultPadding,
    this.showborder = SmeupDatePickerModel.defaultShowBorder,
  }) {
    SmeupDatePickerModel.setDefaults(this);
    if (!showborder) {
      borderWidth = 0;
    }
  }

  @override
  _SmeupDatePickerButtonState createState() => _SmeupDatePickerButtonState();
}

class _SmeupDatePickerButtonState extends State<SmeupDatePickerButton> {
  DateTime _currentValue;
  String _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.value;
    _currentDisplay = widget.display;
    SmeupVariablesService.setVariable(widget.id, widget.display,
        formKey: widget.formKey);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = Container(
      //color: SmeupConfigurationService.getTheme().canvasColor,
      height: 20,
      padding: widget.padding,
      child:
          // SizedBox(
          //   height: widget.height,
          //   width: widget.width,
          //   child:
          ElevatedButton(
              style: widget.buttonStyle,
              onPressed: () {
                DatePicker.showDatePicker(context,
                    currentTime: _currentValue,
                    showTitleActions: true, onConfirm: (date) {
                  setState(() {
                    final newTime = DateFormat('dd/MM/yyyy').format(date);
                    _currentDisplay = newTime;
                    _currentValue = date;
                    SmeupVariablesService.setVariable(widget.id, newTime,
                        formKey: widget.formKey);
                  });
                });
              },
              child: Text(_currentDisplay, style: widget.textStyle)),
      //),
    );

    return button;
  }
}
