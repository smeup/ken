import 'package:flutter/material.dart';
import 'package:ken/smeup/models/widgets/ken_radio_buttons_model.dart';

import '../services/ken_theme_configuration_service.dart';

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
      {this.id = '',
      this.type = 'rad',
      this.title = '',
      this.radioButtonColor,
      this.fontSize,
      this.fontColor,
      this.backColor,
      this.fontBold,
      this.captionFontSize,
      this.captionFontColor,
      this.captionBackColor,
      this.captionFontBold,
      this.data,
      this.width = KenRadioButtonsModel.defaultWidth,
      this.height = KenRadioButtonsModel.defaultHeight,
      this.align = KenRadioButtonsModel.defaultAlign,
      this.padding = KenRadioButtonsModel.defaultPadding,
      this.valueField = KenRadioButtonsModel.defaultValueField,
      this.displayedField = KenRadioButtonsModel.defaultDisplayedField,
      this.selectedValue,
      this.icon,
      this.onPressed}) {
    KenRadioButtonsModel.setDefaults(this);
  }

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

    return Container(
      height: widget.height,
      child: SizedBox(
          height: widget.height,
          width: widget.width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: widget.data!['code'],
                groupValue: _selectedValue,
                onChanged: (dynamic value) {
                  widget.onPressed!(value);
                  _selectedValue = value;
                  setState(() {});
                  if (widget.others != null) {
                    widget.others!.forEach((element) {
                      element.changeState(value);
                    });
                  }
                },
                activeColor:
                    radioThemeData.fillColor!.resolve(Set<MaterialState>()),
              ),
              Expanded(
                child: Align(
                    alignment: widget.align!,
                    child: Text(widget.data!['value']!,
                        textAlign: TextAlign.left, style: _getTextStile())),
              )
            ],
          )),
    );
  }

  RadioThemeData _getRadioTheme() {
    RadioThemeData themeData = KenThemeConfigurationService.getTheme()!
        .radioTheme
        .copyWith(
            fillColor:
                MaterialStateProperty.all<Color?>(widget.radioButtonColor));

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style = KenThemeConfigurationService.getTheme()!.textTheme.bodyText1!;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
