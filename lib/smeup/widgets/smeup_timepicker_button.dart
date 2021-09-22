import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker_customization.dart';

class SmeupTimePickerButton extends StatefulWidget {
  final DateTime value;
  final String display;
  final SmeupTimePickerModel smeupTimePickerModel;
  final GlobalKey<FormState> formKey;

  SmeupTimePickerButton(
      this.smeupTimePickerModel, this.formKey, this.value, this.display);

  @override
  _SmeupTimePickerButtonState createState() => _SmeupTimePickerButtonState();
}

class _SmeupTimePickerButtonState extends State<SmeupTimePickerButton> {
  DateTime _currentValue;
  String _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.value;
    _currentDisplay = widget.display;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = Container(
        color: SmeupConfigurationService.getTheme()
            .canvasColor, // Color.fromRGBO(250, 250, 250, 1),
        padding: EdgeInsets.all(widget.smeupTimePickerModel.padding),
        child: SizedBox(
            height: widget.smeupTimePickerModel.height,
            width: widget.smeupTimePickerModel.width == 0
                ? double.infinity
                : widget.smeupTimePickerModel.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.smeupTimePickerModel.backColor == null
                      ? SmeupConfigurationService.getTheme().buttonColor
                      : widget.smeupTimePickerModel.backColor,
                ),
                onPressed: () {
                  DatePicker.showPicker(context,
                      pickerModel: SmeupTimePickerCustomization(
                          currentTime: _currentValue,
                          showSecondsColumn: false,
                          minutesList: widget.smeupTimePickerModel.minutesList),
                      showTitleActions: true, onConfirm: (date) {
                    setState(() {
                      final newTime = DateFormat('HH:mm').format(date);
                      _currentDisplay = newTime;
                      _currentValue = date;
                      SmeupVariablesService.setVariable(
                          widget.smeupTimePickerModel.id, newTime,
                          formKey: widget.formKey);
                    });
                  });
                },
                child: Text(_currentDisplay,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: widget.smeupTimePickerModel.fontsize,
                        //fontWeight: FontWeight.bold,
                        color: widget.smeupTimePickerModel.fontColor == null
                            ? SmeupConfigurationService.getTheme()
                                .textTheme
                                .bodyText1
                                .color
                            : widget.smeupTimePickerModel.fontColor)))));

    // var containerBackground = SmeupOptions.getTheme().primaryColor;
    // if (widget.smeupTimePickerModel.backColor != null)
    //   containerBackground = widget.smeupTimePickerModel.backColor;

    // final container = Container(
    //   color: containerBackground,
    //   child: button,
    // );

    return button;
  }
}
