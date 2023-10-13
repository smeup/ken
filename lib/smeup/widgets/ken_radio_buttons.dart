// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_not_available.dart';
import 'ken_radio_button.dart';

class KenRadioButtons extends StatefulWidget {
  Color? radioButtonColor;
  Color? fontColor;
  double? fontSize;
  Color? backColor;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  Function? clientOnPressed;
  EdgeInsetsGeometry? padding;
  double? width;
  double? height;
  Alignment? align;
  List<dynamic>? data;
  String? valueField;
  String? displayedField;
  String? selectedValue;
  int? columns;
  String? id;
  String? type;
  String? title;

  KenRadioButtons({
    this.id = '',
    this.type = 'FLD',
    this.title = '',
    this.radioButtonColor = KenRadioButtonsDefaults.defaultRadioButtonColor,
    this.fontSize = KenRadioButtonsDefaults.defaultFontSize,
    this.fontColor = KenRadioButtonsDefaults.defaultFontColor,
    this.backColor = KenRadioButtonsDefaults.defaultBackColor,
    this.fontBold = KenRadioButtonsDefaults.defaultFontBold,
    this.captionFontSize = KenRadioButtonsDefaults.defaultCaptionFontSize,
    this.captionFontColor = KenRadioButtonsDefaults.defaultFontColor,
    this.captionBackColor = KenRadioButtonsDefaults.defaultCaptionBackColor,
    this.captionFontBold = KenRadioButtonsDefaults.defaultFontBold,
    this.data,
    this.width = KenRadioButtonsDefaults.defaultWidth,
    this.height = KenRadioButtonsDefaults.defaultHeight,
    this.align = KenRadioButtonsDefaults.defaultAlign,
    this.padding = KenRadioButtonsDefaults.defaultPadding,
    this.valueField = KenRadioButtonsDefaults.defaultValueField,
    this.displayedField = KenRadioButtonsDefaults.defaultDisplayedField,
    this.selectedValue,
    this.clientOnPressed,
    this.columns = KenRadioButtonsDefaults.defaultColumns,
  });

  @override
  KenRadioButtonsState createState() => KenRadioButtonsState();
}

class KenRadioButtonsState extends State<KenRadioButtons> {
  dynamic _data;

  @override
  void initState() {
    _data = widget.data;

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    var buttons = List<Widget>.empty(growable: true);

    int buttonIndex = 0;

    _data.forEach((radioButtonData) {
      buttonIndex += 1;

      final button = KenRadioButton(
        id: '${widget.id}_${buttonIndex.toString()}',
        type: widget.type,
        title: widget.title,
        data: radioButtonData,
        backColor: widget.backColor,
        width: widget.width,
        height: widget.height,
        align: widget.align,
        fontColor: widget.fontColor,
        fontSize: widget.fontSize,
        padding: widget.padding,
        valueField: widget.valueField,
        displayedField: widget.displayedField,
        radioButtonColor: widget.radioButtonColor,
        selectedValue: widget.selectedValue,
        icon: null, // così anche in originale
      );
      buttons.add(button);
    });

    if (buttons.isNotEmpty) {
      for (var i = 0; i < buttons.length; i++) {
        if (buttons[i] is KenRadioButton) {
          var others = List<KenRadioButton>.empty(growable: true);
          for (var k = 0; k < buttons.length; k++) {
            if (i != k && buttons[k] is KenRadioButton) {
              others.add(buttons[k] as KenRadioButton);
            }
          }
          (buttons[i] as KenRadioButton).others = others;
        }
      }

      double childAspectRatio = 0;
      childAspectRatio = (widget.width! / widget.height! * buttons.length * 3) /
          widget.columns!;

      TextStyle captionStyle = _getCaptionStile();

      var title = Container(
          alignment: Alignment.centerLeft,
          child: Text(
            widget.title!.isNotEmpty ? widget.title! : '',
            style: captionStyle,
          ));

      final container = Padding(
        padding: widget.padding!,
        child: Column(
          children: [
            title,
            GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              childAspectRatio: childAspectRatio,
              crossAxisCount: widget.columns!,
              children: buttons,
            )
          ],
        ),
      );

      KenMessageBus.instance.fireEvent(
        RadioButtonSelDataEvent(
          widgetId: widget.id!,
          value: _data,
        ),
      );

      return container;
    } else {
      // KenLogService.writeDebugMessage(
      //     'Error SmeupRadioButtons no children \'radio button\' created',
      //     logType: KenLogType.error);
      // return KenWidgetBuilderResponse(_model, KenNotAvailable());
      return KenNotAvailable();
    }
  }

  TextStyle _getCaptionStile() {
    TextStyle style = TextStyle(
        color: widget.captionFontColor,
        fontSize: widget.captionFontSize,
        backgroundColor: widget.captionBackColor);

    if (widget.captionFontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    } else {
      style = style.copyWith(
        fontWeight: FontWeight.normal,
      );
    }

    return style;
  }
}
