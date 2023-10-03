// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import '../models/widgets/ken_radio_buttons_model.dart';

// ignore: must_be_immutable
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
      this.radioButtonColor = KenRadioButtonsModel.defaultRadioButtonColor,
      this.fontSize = KenRadioButtonsModel.defaultFontSize,
      this.fontColor = KenRadioButtonsModel.defaultFontColor,
      this.backColor = KenRadioButtonsModel.defaultBackColor,
      this.fontBold = KenRadioButtonsModel.defaultFontBold,
      this.captionFontSize = KenRadioButtonsModel.defaultCaptionFontSize,
      this.captionFontColor = KenRadioButtonsModel.defaultFontColor,
      this.captionBackColor = KenRadioButtonsModel.defaultCaptionBackColor,
      this.captionFontBold = KenRadioButtonsModel.defaultCaptionFontBold,
      this.data,
      this.width = KenRadioButtonsModel.defaultWidth,
      this.height = KenRadioButtonsModel.defaultHeight,
      this.align = KenRadioButtonsModel.defaultAlign,
      this.padding = KenRadioButtonsModel.defaultPadding,
      this.valueField = KenRadioButtonsModel.defaultValueField,
      this.displayedField = KenRadioButtonsModel.defaultDisplayedField,
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
    RadioThemeData radioThemeData = _getRadioTheme();

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
