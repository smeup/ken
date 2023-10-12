// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../services/ken_defaults.dart';

class KenRadioButton extends StatefulWidget {
  Color? radioButtonColor;
  Color? backColor;
  Color? fontColor;
  double? fontSize;
  bool? fontBold;
  bool? captionFontBold;
  double? captionFontSize;
  Color? captionFontColor;
  Color? captionBackColor;

  final IconData? icon;
  final Function? onPressed;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Alignment? align;
  final Map<String, String>? data;
  final String? valueField;
  final String? displayedField;
  final String? selectedValue;
  final String id;
  final String? type;
  final String? title;
  List<KenRadioButton>? others;
  late Function changeState;

  KenRadioButton(
      {super.key,
      this.id = '',
      this.type = 'rad',
      this.title = '',
      this.radioButtonColor = KenRadioButtonsDefaults.defaultRadioButtonColor,
      this.fontSize = KenRadioButtonsDefaults.defaultFontSize,
      this.fontColor = KenRadioButtonsDefaults.defaultFontColor,
      this.backColor = KenRadioButtonsDefaults.defaultBackColor,
      this.fontBold = KenRadioButtonsDefaults.defaultFontBold,
      this.captionFontSize = KenRadioButtonsDefaults.defaultCaptionFontSize,
      this.captionFontColor = KenRadioButtonsDefaults.defaultFontColor,
      this.captionBackColor = KenRadioButtonsDefaults.defaultCaptionBackColor,
      this.captionFontBold = KenRadioButtonsDefaults.defaultCaptionFontBold,
      this.data,
      this.width = KenRadioButtonsDefaults.defaultWidth,
      this.height = KenRadioButtonsDefaults.defaultHeight,
      this.align = KenRadioButtonsDefaults.defaultAlign,
      this.padding = KenRadioButtonsDefaults.defaultPadding,
      this.valueField = KenRadioButtonsDefaults.defaultValueField,
      this.displayedField = KenRadioButtonsDefaults.defaultDisplayedField,
      this.selectedValue,
      this.icon,
      this.onPressed});

  @override
  State<KenRadioButton> createState() => _KenRadioButtonState();
}

class _KenRadioButtonState extends State<KenRadioButton> {
  String? _selectedValue = '';

  @override
  void initState() {
    _selectedValue = widget.selectedValue;
    widget.changeState = (value) {
      setState(() {
        _selectedValue = value;
      });
    };
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //RadioThemeData radioThemeData = _getRadioTheme();

    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Transform.scale(
            scale: 1.2,
            child: Radio(
              value: widget.data!['code'],
              groupValue: _selectedValue,
              onChanged: (dynamic value) {
                widget.onPressed!(value);
                _selectedValue = value;
                setState(() {});
                if (widget.others != null) {
                  for (var element in widget.others!) {
                    element.changeState(value);
                  }
                }
              },
              activeColor: widget.fontColor,
            ),
          ),
          Expanded(
            child: Align(
                alignment: widget.align!,
                child: Text(widget.data!['value']!,
                    textAlign: TextAlign.left, style: _getTextStile())),
          )
        ],
      ),
    );
  }

  RadioThemeData _getRadioTheme() {
    RadioThemeData themeData = RadioThemeData(
        fillColor: MaterialStateProperty.all<Color?>(widget.radioButtonColor));

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style = TextStyle(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold!) {
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
