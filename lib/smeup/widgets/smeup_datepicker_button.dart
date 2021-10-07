import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';

// ignore: must_be_immutable
class SmeupDatePickerButton extends StatefulWidget {
  final DateTime value;
  String display;
  final String id;

  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  //Graphics properties
  Color backColor;
  double fontsize;
  Color fontColor;
  String label;
  double width;
  double height;
  EdgeInsetsGeometry padding;
  bool showborder;
  double elevation;

  SmeupDatePickerButton(
    this.id, {
    this.scaffoldKey,
    this.formKey,
    this.value,
    this.display,
    this.backColor = SmeupDatePickerModel.defaultBackColor,
    this.fontsize = SmeupDatePickerModel.defaultFontsize,
    this.fontColor = SmeupDatePickerModel.defaultFontColor,
    this.label = SmeupDatePickerModel.defaultLabel,
    this.width = SmeupDatePickerModel.defaultWidth,
    this.height = SmeupDatePickerModel.defaultHeight,
    this.padding = SmeupDatePickerModel.defaultPadding,
    this.showborder = SmeupDatePickerModel.defaultShowBorder,
    this.elevation = SmeupDatePickerModel.defaultElevation,
  });

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
      color: SmeupConfigurationService.getTheme().canvasColor,
      padding: widget.padding,
      child: SizedBox(
        height: widget.height,
        width: widget.width == 0 ? double.infinity : widget.width,
        child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(0.0),
              elevation: widget.elevation,
              primary: widget.backColor == null
                  ? SmeupConfigurationService.getTheme()
                      .buttonTheme
                      .colorScheme
                      .onPrimary
                  : widget.backColor,
              alignment: Alignment.center,
            ),
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
            child: Text(_currentDisplay,
                style: TextStyle(
                    fontSize: widget.fontsize,
                    color: widget.fontColor == null
                        ? SmeupConfigurationService.getTheme()
                            .textTheme
                            .bodyText1
                            .color
                        : widget.fontColor))),
      ),
    );

    return button;
  }
}
