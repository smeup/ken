import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/models_components/smeup_radio_buttons_model.dart';

class SmeupRadioButton extends StatelessWidget {
  final IconData icon;
  final Function onServerPressed;
  final Function onClientPressed;
  final SmeupRadioButtonsModel smeupRadioButtonsModel;
  final dynamic data;
  final String selectedValue;
  const SmeupRadioButton(
      {Key key,
      this.smeupRadioButtonsModel,
      this.icon,
      this.onServerPressed,
      this.onClientPressed,
      this.data,
      this.selectedValue})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
          height: smeupRadioButtonsModel.height,
          width: smeupRadioButtonsModel.width == 0
              ? double.infinity
              : smeupRadioButtonsModel.width,
          child: Row(
            children: [
              Radio(
                value: data[smeupRadioButtonsModel.valueField],
                groupValue: selectedValue,
                onChanged:
                    onClientPressed != null ? onClientPressed : onServerPressed,
                activeColor: SmeupOptions.theme.primaryColor,
              ),
              Align(
                  alignment: smeupRadioButtonsModel.align,
                  child: Text(data[smeupRadioButtonsModel.displayedField],
                      style: TextStyle(
                          fontSize: smeupRadioButtonsModel.fontsize,
                          fontWeight: FontWeight.bold,
                          color: smeupRadioButtonsModel.fontColor)))
            ],
          )),
    );
  }
}
