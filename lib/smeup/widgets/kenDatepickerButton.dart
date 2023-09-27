import 'package:flutter/material.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart'
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as datepicker;
import 'package:intl/intl.dart';
import '../models/KenMessageBusEventData.dart';
import '../models/widgets/ken_datepicker_model.dart';
import '../services/ken_message_bus.dart';
import 'kenTimepicker.dart';

// ignore: must_be_immutable
class KenDatePickerButton extends StatefulWidget {
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
  KenDatePickerModel? model;
  final Function? clientOnChange;
  Color? dashColor;

  final DateTime? value;
  final String? id;
  final String? display;
  final String? label;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool? showborder;
  final Alignment? align;

  final ButtonStyle buttonStyle;
  final TextStyle textStyle;

  final String globallyUniqueId;

  KenDatePickerButton(
    this.id,
    this.buttonStyle,
    this.textStyle, {
    super.key,
    this.scaffoldKey,
    this.formKey,
    this.value,
    this.display = KenDatePickerModel.defaultdisplayedField,
    this.borderColor = KenDatePickerModel.defaultBorderColor,
    this.borderWidth = KenDatePickerModel.defaultBorderWidth,
    this.borderRadius = KenDatePickerModel.defaultBorderRadius,
    this.fontBold = KenDatePickerModel.defaultFontBold,
    this.fontSize = KenDatePickerModel.defaultFontSize,
    this.fontColor = KenDatePickerModel.defaultFontColor,
    this.backColor = KenDatePickerModel.defaultBackColor,
    this.elevation = KenDatePickerModel.defaultElevation,
    this.captionFontBold = KenDatePickerModel.defaultCaptionFontBold,
    this.captionFontSize = KenDatePickerModel.defaultCaptionFontSize,
    this.captionFontColor = KenDatePickerModel.defaultCaptionFontColor,
    this.captionBackColor = KenDatePickerModel.defaultCaptionBackColor,
    this.underline = KenDatePickerModel.defaultUnderline,
    this.align = KenDatePickerModel.defaultAlign,
    this.label = KenDatePickerModel.defaultLabel,
    this.width = KenDatePickerModel.defaultWidth,
    this.height = KenDatePickerModel.defaultHeight,
    this.padding = KenDatePickerModel.defaultPadding,
    this.showborder = KenDatePickerModel.defaultShowBorder,
    this.clientOnChange,
    this.model,
    this.dashColor = KenDatePickerModel.defaultDashColor,
    required this.globallyUniqueId,
  }) {}

  @override
  KenDatePickerButtonState createState() => KenDatePickerButtonState();
}

class KenDatePickerButtonState extends State<KenDatePickerButton> {
  DateTime? _currentValue;
  String? _currentDisplay;

  @override
  void initState() {
    _currentValue = widget.value;
    _currentDisplay = widget.display;

    KenMessageBus.instance.publishRequest(
      widget.globallyUniqueId,
      KenTopic.kenDatePickerInit,
      KenMessageBusEventData(
          context: context, widget: widget, model: null, data: null),
    );
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
              datepicker.DatePicker.showDatePicker(context,
                  theme: datepicker.DatePickerTheme(
                      backgroundColor: widget.dashColor!,
                      // headerColor: widget.textStyle.backgroundColor,
                      doneStyle: widget.textStyle,
                      cancelStyle: widget.textStyle,
                      itemStyle: widget.textStyle),
                  currentTime: _currentValue,
                  showTitleActions: true, onConfirm: (date) {
                setState(() {
                  final newDate = DateFormat('dd/MM/yyyy').format(date);
                  _currentDisplay = newDate;
                  _currentValue = date;

                  KenMessageBus.instance.publishRequest(
                    widget.globallyUniqueId,
                    KenTopic.kenDatePickerOnPressed,
                    KenMessageBusEventData(
                        context: context,
                        widget: widget,
                        model: null,
                        data: newDate),
                  );

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
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(_currentDisplay!, style: widget.textStyle),
              ),
            )),
      ),
    );

    return button;
  }
}
