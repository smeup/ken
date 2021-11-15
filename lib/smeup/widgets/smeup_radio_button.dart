import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';

// ignore: must_be_immutable
class SmeupRadioButton extends StatefulWidget {
  final IconData icon;
  final Function onPressed;

  //final dynamic data;

  final EdgeInsetsGeometry padding;
  final Color backColor;
  final double width;
  final double height;
  final MainAxisAlignment position;
  final Alignment align;
  final Color fontColor;
  final double fontsize;
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
      this.data,
      this.backColor,
      this.width = SmeupRadioButtonsModel.defaultWidth,
      this.height = SmeupRadioButtonsModel.defaultHeight,
      this.position = SmeupRadioButtonsModel.defaultPosition,
      this.align = SmeupRadioButtonsModel.defaultAlign,
      this.fontColor,
      this.fontsize = SmeupRadioButtonsModel.defaultFontsize,
      this.padding = SmeupRadioButtonsModel.defaultPadding,
      this.valueField = SmeupRadioButtonsModel.defaultValueField,
      this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
      this.selectedValue,
      this.icon,
      this.onPressed});

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
                activeColor: SmeupConfigurationService.getTheme().primaryColor,
              ),
              Expanded(
                child: Align(
                    alignment: widget.align,
                    child: Text(widget.data['value'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: widget.fontsize,
                            fontWeight: FontWeight.bold,
                            color: widget.fontColor))),
              )
            ],
          )),
    );
  }
}
