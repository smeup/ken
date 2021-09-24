import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_timepicker_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker.dart';
import 'package:mobile_components_library/smeup/widgets/smeup_timepicker_customization.dart';

class SmeupTimePickerButton extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final String id;

  final Color backColor;
  final double fontsize;
  final Color fontColor;
  final String label;
  final double width;
  final double height;
  final double padding;
  final bool showborder;
  final List<String> minutesList;

  final SmeupTimePickerData data;

  final Function clientOnChange;

  SmeupTimePickerButton(
    this.formKey,
    this.data, {
    this.id = '',
    this.backColor = SmeupTimePickerModel.defaultBackColor,
    this.fontsize = SmeupTimePickerModel.defaultFontsize,
    this.fontColor = SmeupTimePickerModel.defaultFontColor,
    this.label = SmeupTimePickerModel.defaultLabel,
    this.width = SmeupTimePickerModel.defaultWidth,
    this.height = SmeupTimePickerModel.defaultHeight,
    this.padding = SmeupTimePickerModel.defaultPadding,
    this.showborder = SmeupTimePickerModel.defaultShowBorder,
    this.minutesList,
    this.clientOnChange,
  });

  @override
  _SmeupTimePickerButtonState createState() => _SmeupTimePickerButtonState();
}

class _SmeupTimePickerButtonState extends State<SmeupTimePickerButton> {
  DateTime _currentValue;
  String _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.data.time;
    _currentDisplay = widget.data.formattedTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final button = Container(
        color: SmeupConfigurationService.getTheme()
            .canvasColor, // Color.fromRGBO(250, 250, 250, 1),
        padding: EdgeInsets.all(widget.padding),
        child: SizedBox(
            height: widget.height,
            width: widget.width == 0 ? double.infinity : widget.width,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: widget.backColor == null
                      ? SmeupConfigurationService.getTheme().buttonColor
                      : widget.backColor,
                ),
                onPressed: () {
                  DatePicker.showPicker(context,
                      pickerModel: SmeupTimePickerCustomization(
                          currentTime: _currentValue,
                          showSecondsColumn: false,
                          minutesList: widget.minutesList),
                      showTitleActions: true, onConfirm: (date) {
                    setState(() {
                      final newTime = DateFormat('HH:mm').format(date);
                      _currentDisplay = newTime;
                      _currentValue = date;
                      if (widget.clientOnChange != null) {
                        widget.clientOnChange(SmeupTimePickerData(
                          time: _currentValue,
                          formattedTime: _currentDisplay,
                        ));
                      }
                      SmeupVariablesService.setVariable(widget.id, newTime,
                          formKey: widget.formKey);
                    });
                  });
                },
                child: Text(_currentDisplay,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: widget.fontsize,
                        //fontWeight: FontWeight.bold,
                        color: widget.fontColor == null
                            ? SmeupConfigurationService.getTheme()
                                .textTheme
                                .bodyText1
                                .color
                            : widget.fontColor)))));

    return button;
  }
}
