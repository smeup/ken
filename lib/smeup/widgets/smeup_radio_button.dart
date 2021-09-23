import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';
import 'package:mobile_components_library/smeup/models/widgets/smeup_radio_buttons_model.dart';

class SmeupRadioButton extends StatelessWidget {
  final IconData icon;
  final Function serverOnPressed;
  final Function clientOnPressed;
  //final dynamic data;

  final Color backColor;
  final double width;
  final double height;
  final MainAxisAlignment position;
  final Alignment align;
  final Color fontColor;
  final double fontsize;
  final double padding;
  final Map<String, String> data;
  final double rightPadding;
  final double leftPadding;
  final double topPadding;
  final double bottomPadding;
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
      this.leftPadding = SmeupRadioButtonsModel.defaultPadding,
      this.rightPadding = SmeupRadioButtonsModel.defaultPadding,
      this.topPadding = SmeupRadioButtonsModel.defaultPadding,
      this.bottomPadding = SmeupRadioButtonsModel.defaultPadding,
      this.valueField = SmeupRadioButtonsModel.defaultValueField,
      this.displayedField = SmeupRadioButtonsModel.defaultDisplayedField,
      this.selectedValue,
      this.icon,
      this.serverOnPressed,
      this.clientOnPressed});

  @override
  Widget build(BuildContext context) {
    var _selectedValue = selectedValue;
    return Container(
      child: SizedBox(
          height: height,
          width: width == 0 ? double.infinity : width,
          child: Row(
            children: [
              Radio(
                value: data['code'],
                groupValue: _selectedValue,
                onChanged: (value) {
                  serverOnPressed(value);
                },
                activeColor: SmeupConfigurationService.getTheme().primaryColor,
              ),
              Align(
                  alignment: align,
                  child: Text(data['value'],
                      style: TextStyle(
                          fontSize: fontsize,
                          fontWeight: FontWeight.bold,
                          color: fontColor)))
            ],
          )),
    );
  }
}
