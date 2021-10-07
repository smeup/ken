import 'package:flutter/material.dart';
import 'package:mobile_components_library/smeup/services/smeup_configuration_service.dart';

class SmeupDrawerItem extends StatelessWidget {
  final String text;
  final String route;
  final int iconCode;
  final Function action;
  final double fontSize;
  final Alignment align;

  SmeupDrawerItem(this.text, this.route, this.iconCode, this.action,
      this.fontSize, this.align);

  @override
  Widget build(BuildContext context) {
    final title = Align(
        alignment: align,
        child: Text(text, style: TextStyle(fontSize: fontSize)));
    Function function = () {
      if (action != null) {
        action();
      } else {
        Navigator.of(context).pushNamed(route);
      }
    };

    return Container(
        child: Column(
      children: [
        Divider(),
        if (iconCode > 0)
          ListTile(
            leading: Icon(
              IconData(iconCode, fontFamily: 'MaterialIcons'),
              color: SmeupConfigurationService.getTheme().primaryColor,
            ),
            title: title,
            onTap: function,
          )
        else
          ListTile(
            title: title,
            onTap: function,
          ),
      ],
    ));
  }
}
