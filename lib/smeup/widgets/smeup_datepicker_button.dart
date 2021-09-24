import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_datepicker_model.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_line_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_line.dart';

class SmeupDatePickerButton extends StatefulWidget {
  final DateTime value;
  final String display;
  final SmeupDatePickerModel smeupDatePickerModel;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupDatePickerButton(this.smeupDatePickerModel, this.scaffoldKey,
      this.formKey, this.value, this.display);

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
    SmeupVariablesService.setVariable(
        widget.smeupDatePickerModel.id, widget.display,
        formKey: widget.formKey);
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
        color: SmeupConfigurationService.getTheme().scaffoldBackgroundColor,
        padding: EdgeInsets.all(widget.smeupDatePickerModel.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.smeupDatePickerModel.label,
                style: TextStyle(
                  color: SmeupConfigurationService.getTheme().primaryColor,
                  fontSize: labelSize,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: double.infinity,
                  height: widget.smeupDatePickerModel.height),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    elevation: widget.smeupDatePickerModel.elevation,
                    primary: widget.smeupDatePickerModel.backColor == null
                        ? SmeupConfigurationService.getTheme()
                            .buttonTheme
                            .colorScheme
                            .background
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
                        SmeupVariablesService.setVariable(
                            widget.smeupDatePickerModel.id, newTime,
                            formKey: widget.formKey);
                      });
                    });
                  },
                  child: Text(_currentDisplay,
                      style: TextStyle(
                          fontSize: widget.smeupDatePickerModel.fontsize,
                          color: widget.smeupDatePickerModel.fontColor == null
                              ? SmeupConfigurationService.getTheme()
                                  .textTheme
                                  .bodyText1
                                  .color
                              : widget.smeupDatePickerModel.fontColor))),
            ),
            SmeupLine(
                SmeupLineModel(widget.formKey,
                    color: SmeupConfigurationService.getTheme().primaryColor,
                    thickness: 0.5),
                widget.scaffoldKey,
                widget.formKey)
          ],
        ));

    return button;
  }
}
