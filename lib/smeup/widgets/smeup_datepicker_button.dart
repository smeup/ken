import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';

class SmeupDatePickerButton extends StatefulWidget {
  final DateTime value;
  final String display;
  final SmeupDatePickerModel smeupDatePickerModel;

  SmeupDatePickerButton(this.smeupDatePickerModel, this.value, this.display);

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
    SmeupDynamismService.variables[widget.smeupDatePickerModel.id] =
        widget.display;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double labelSize = widget.smeupDatePickerModel.fontsize > 2
        ? widget.smeupDatePickerModel.fontsize - 2
        : widget.smeupDatePickerModel.fontsize;

    final button = Container(
        height: widget.smeupDatePickerModel.height,
        width: widget.smeupDatePickerModel.width == 0
            ? double.infinity
            : widget.smeupDatePickerModel.width,
        color: SmeupOptions.theme.scaffoldBackgroundColor,
        padding: EdgeInsets.all(widget.smeupDatePickerModel.padding),
        child: Column(
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.smeupDatePickerModel.label,
                style: TextStyle(
                  color: SmeupOptions.theme.primaryColor,
                  fontSize: labelSize,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(width: double.infinity),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    elevation: widget.smeupDatePickerModel.elevation,
                    primary: widget.smeupDatePickerModel.backColor == null
                        ? SmeupOptions.theme.buttonColor
                        : widget.smeupDatePickerModel.backColor,
                    alignment: Alignment.centerLeft,
                  ),
                  onPressed: () {
                    DatePicker.showDatePicker(context,
                        currentTime: _currentValue,
                        showTitleActions: true, onConfirm: (date) {
                      setState(() {
                        final newTime = DateFormat('dd/MM/yyyy').format(date);
                        _currentDisplay = newTime;
                        _currentValue = date;
                        SmeupDynamismService
                                .variables[widget.smeupDatePickerModel.id] =
                            newTime;
                      });
                    });
                  },
                  child: Text(_currentDisplay,
                      style: TextStyle(
                          fontSize: widget.smeupDatePickerModel.fontsize,
                          color: widget.smeupDatePickerModel.fontColor == null
                              ? SmeupOptions.theme.textTheme.bodyText1.color
                              : widget.smeupDatePickerModel.fontColor))),
            ),
          ],
        ));

    return button;
  }
}
