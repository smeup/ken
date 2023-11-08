// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';
import '../helpers/ken_utilities.dart';
import '../services/message_bus/ken_message_bus.dart';
import '../services/message_bus/ken_message_bus_event.dart';
import 'ken_not_available.dart';
import 'ken_radio_button.dart';

class KenRadioButtons extends StatefulWidget {
  final Color? radioButtonColor;
  final Color? fontColor;
  final double? fontSize;
  final Color? backColor;
  final bool? fontBold;
  final bool? captionFontBold;
  final double? captionFontSize;
  final Color? captionFontColor;
  final Color? captionBackColor;

  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Alignment? align;
  final List<dynamic>? data;
  final String? valueField;
  final String? displayedField;
  final String? selectedValue;
  final int? columns;
  final String? id;
  final String? type;
  final String? title;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final GlobalKey<FormState>? formKey;

  const KenRadioButtons({
    super.key,
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
    this.columns = KenRadioButtonsDefaults.defaultColumns,
    this.scaffoldKey,
    this.formKey,
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
      final buttonId = '${widget.id}_${buttonIndex.toString()}';
      final keyId =
          '${(widget.key as ValueKey).value}_${buttonIndex.toString()}';
      // KenMessageBus.instance
      //     .event<RadioButtonOnPressedEvent>(buttonId)
      //     .takeWhile((element) => context.mounted)
      //     .listen((event) {
      //   event.messageBusId =
      //       KenUtilities.getMessageBusId(widget.id!, widget.scaffoldKey);
      //   KenMessageBus.instance.fireEvent(event);
      // });
      final button = KenRadioButton(
        id: buttonId,
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
        scaffoldKey: widget.scaffoldKey,
        formKey: widget.formKey,
        key: Key('${keyId}_radio_button'),
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
          messageBusId:
              KenUtilities.getMessageBusId(widget.id!, widget.scaffoldKey),
          value: _data,
        ),
      );

      return container;
    } else {
      debugPrint(
          'Error SmeupRadioButtons no children \'radio button\' created');
      return const KenNotAvailable();
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
