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
  double padding;
  bool showborder;
  double elevation;

  SmeupDatePickerButton(
    this.id, {
    this.scaffoldKey,
    this.formKey,
    this.value,
    this.display,
    this.backColor,
    this.fontsize = SmeupDatePickerModel.defaultFontsize,
    this.fontColor,
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
    double labelSize =
        widget.fontsize > 2 ? widget.fontsize - 2 : widget.fontsize;

    final button = Container(
        height: widget.height,
        width: widget.width == 0 ? double.infinity : widget.width,
        color: SmeupConfigurationService.getTheme().scaffoldBackgroundColor,
        padding: EdgeInsets.all(widget.padding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.bottomLeft,
              child: Text(
                widget.label,
                style: TextStyle(
                  color: SmeupConfigurationService.getTheme().primaryColor,
                  fontSize: labelSize,
                ),
              ),
            ),
            ConstrainedBox(
              constraints: BoxConstraints.tightFor(
                  width: double.infinity, height: widget.height),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(0.0),
                    elevation: widget.elevation,
                    primary: widget.backColor == null
                        // ignore: deprecated_member_use
                        ? SmeupConfigurationService.getTheme().buttonColor
                        : widget.backColor,
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
