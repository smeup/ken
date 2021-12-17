import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/models/widgets/smeup_radio_buttons_model.dart';

// ignore: must_be_immutable
class SmeupRadioButton extends StatefulWidget {
  Color radioButtonColor;
  Color backColor;
  Color fontColor;
  double fontSize;
  bool fontBold;
  bool captionFontBold;
  double captionFontSize;
  Color captionFontColor;
  Color captionBackColor;

  final IconData icon;
  final Function onPressed;
  final EdgeInsetsGeometry padding;
  final double width;
  final double height;
  final Alignment align;
  final Map<String, String> data;
  final String valueField;
  final String displayedField;
  final String selectedValue;
  final String id;
  final String type;
  final String title;
  List<SmeupRadioButton> others;
  Function changeState;

  SmeupRadioButton(
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
      this.width = SmeupRadioButtonsModel.defaultWidth,
      this.height = SmeupRadioButtonsModel.defaultHeight,
      this.align = SmeupRadioButtonsModel.defaultAlign,
      this.padding = SmeupRadioButtonsModel.defaultPadding,
      this.valueField = SmeupRadioButtonsModel.defaultValueField,
      this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
      this.selectedValue,
      this.icon,
      this.onPressed}) {
    SmeupRadioButtonsModel.setDefaults(this);
  }

  @override
  State<SmeupRadioButton> createState() => _SmeupRadioButtonState();
}

class _SmeupRadioButtonState extends State<SmeupRadioButton> {
  String _selectedValue = '';

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
                value: widget.data['code'],
                groupValue: _selectedValue,
                onChanged: (value) {
                  widget.onPressed(value);
                  _selectedValue = value;
                  setState(() {});
                  if (widget.others != null) {
                    widget.others.forEach((element) {
                      element.changeState(value);
                    });
                  }
                },
                activeColor:
                    radioThemeData.fillColor.resolve(Set<MaterialState>()),
              ),
              Expanded(
                child: Align(
                    alignment: widget.align,
                    child: Text(widget.data['value'],
                        textAlign: TextAlign.left, style: _getTextStile())),
              )
            ],
          )),
    );
  }

  RadioThemeData _getRadioTheme() {
    RadioThemeData themeData = SmeupConfigurationService.getTheme()
        .radioTheme
        .copyWith(
            fillColor:
                MaterialStateProperty.all<Color>(widget.radioButtonColor));

    return themeData;
  }

  TextStyle _getTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme().textTheme.bodyText1;

    style = style.copyWith(
        color: widget.fontColor,
        fontSize: widget.fontSize,
        backgroundColor: widget.backColor);

    if (widget.fontBold) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }
}
