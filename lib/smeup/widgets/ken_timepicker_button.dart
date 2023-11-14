import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datepicker;
import 'package:intl/intl.dart';

import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_timepicker.dart';
import 'ken_timepicker_customization.dart';

class KenTimePickerButton extends StatefulWidget {
  final GlobalKey<ScaffoldState>? formKey;

  final Color? borderColor;
  final double? borderWidth;
  final double? borderRadius;
  final bool? fontBold;
  final double? fontSize;
  final Color? fontColor;
  final Color? backColor;
  final double? elevation;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;
  final bool? underline;
  final Color? dashColor;

  final String? id;

  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final Alignment? align;
  final List<String>? minutesList;
  final KenTimePickerData? data;
  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  const KenTimePickerButton(
    this.data,
    this.buttonStyle,
    this.textStyle, {
    super.key,
    this.formKey,
    this.id = '',
    this.backColor = KenTimepickerDefaults.defaultBackColor,
    this.fontSize = KenTimepickerDefaults.defaultFontSize,
    this.fontColor = KenTimepickerDefaults.defaultFontColor,
    this.borderColor = KenTimepickerDefaults.defaultBorderColor,
    this.borderWidth = KenTimepickerDefaults.defaultBorderWidth,
    this.borderRadius = KenTimepickerDefaults.defaultBorderRadius,
    this.fontBold = KenTimepickerDefaults.defaultFontBold,
    this.elevation = KenTimepickerDefaults.defaultElevation,
    this.captionFontBold = KenTimepickerDefaults.defaultFontBold,
    this.captionFontSize = KenTimepickerDefaults.defaultFontSize,
    this.captionFontColor = KenTimepickerDefaults.defaultCaptionFontColor,
    this.captionBackColor = KenTimepickerDefaults.defaultCaptionBackColor,
    this.underline = KenTimepickerDefaults.defaultUnderline,
    this.align = KenTimepickerDefaults.defaultAlign,
    this.label = KenTimepickerDefaults.defaultLabel,
    this.width = KenTimepickerDefaults.defaultWidth,
    this.height = KenTimepickerDefaults.defaultHeight,
    this.padding = KenTimepickerDefaults.defaultPadding,
    this.showborder = KenTimepickerDefaults.defaultShowBorder,
    this.minutesList = KenTimepickerDefaults.defaultMinutesList,
    this.dashColor,
  });

  @override
  KenTimePickerButtonState createState() => KenTimePickerButtonState();
}

class KenTimePickerButtonState extends State<KenTimePickerButton> {
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
    final button = Padding(
      padding: widget.padding!,
      child: SizedBox(
          height: 40,
          width: widget.width,
          child: ElevatedButton(
              style: widget.buttonStyle,
              onPressed: () {
                datepicker.DatePicker.showPicker(context,
                    theme: datepicker.DatePickerTheme(
                        backgroundColor: widget.dashColor!,
                        // headerColor: widget.textStyle.backgroundColor,
                        doneStyle: widget.textStyle,
                        cancelStyle: widget.textStyle,
                        itemStyle: widget.textStyle),
                    pickerModel: KenTimePickerCustomization(
                        currentTime: _currentValue,
                        showSecondsColumn: false,
                        minutesList: widget.minutesList),
                    showTitleActions: true, onConfirm: (date) {
                  setState(() {
                    final newTime = DateFormat('HH:mm').format(date);
                    _currentDisplay = newTime;
                    _currentValue = date;
                    KenMessageBus.instance.fireEvent(
                      TimePickerOnChangeEvent(
                        messageBusId: KenUtilities.getMessageBusId(
                            widget.id!, widget.formKey),
                        data: KenTimePickerData(
                          time: _currentValue,
                          formattedTime: _currentDisplay,
                        ),
                      ),
                    );
                  });
                });
              },
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: Text(_currentDisplay!, style: widget.textStyle),
                ),
              ))),
    );

    return button;
  }
}
