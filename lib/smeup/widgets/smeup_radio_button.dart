import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';

class SmeupRadioButton extends StatelessWidget {
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

  const SmeupRadioButton(
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
  Widget build(BuildContext context) {
    var _selectedValue = selectedValue;
    return Container(
      height: height,
      child: SizedBox(
          height: height,
          width: width,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Radio(
                value: data['code'],
                groupValue: _selectedValue,
                onChanged: (value) {
                  onPressed(value);
                },
                activeColor: SmeupConfigurationService.getTheme().primaryColor,
              ),
              Expanded(
                child: Align(
                    alignment: align,
                    child: Text(data['value'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: fontsize,
                            fontWeight: FontWeight.bold,
                            color: fontColor))),
              )
            ],
          )),
    );
  }
}
