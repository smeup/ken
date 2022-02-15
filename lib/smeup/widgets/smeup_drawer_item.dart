import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_dynamism_service.dart';

class SmeupDrawerItem extends StatelessWidget {
  final String text;
  final String route;
  final int iconCode;
  final Function action;
  final double fontSize;
  final Color fontColor;
  final bool fontBold;
  final Alignment align;
  final bool showItemDivider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;

  SmeupDrawerItem(this.scaffoldKey, this.formKey, this.text, this.route,
      this.iconCode, this.action, this.align, this.showItemDivider,
      {this.fontSize, this.fontBold, this.fontColor});

  @override
  Widget build(BuildContext context) {
    final title = Align(
        alignment: align, child: Text(text, style: _getElementTextStile()));
    Function function = () {
      if (action != null) {
        action(context);
      } else {
        if (route.trimLeft().toUpperCase().startsWith('F(')) {
          SmeupDynamismService.run([
            {"event": "click", "exec": "$route"}
          ], context, 'click', scaffoldKey, formKey);
        } else {
          Navigator.of(context).pushNamed(route);
        }
      }
    };

    return Container(
        child: Column(
      children: [
        if (showItemDivider)
          Divider(
            color: _getElementTextStile().color,
          ),
        if (iconCode > 0)
          ListTile(
            leading: Icon(
              IconData(iconCode, fontFamily: 'MaterialIcons'),
              color: _getIconTheme().color,
              size: _getIconTheme().size,
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

  TextStyle _getElementTextStile() {
    TextStyle style = SmeupConfigurationService.getTheme()
        .appBarTheme
        .toolbarTextStyle
        .copyWith(
            backgroundColor: SmeupConfigurationService.getTheme()
                .appBarTheme
                .backgroundColor);

    if (fontSize != null)
      style = style.copyWith(
        fontSize: fontSize,
      );

    if (fontColor != null)
      style = style.copyWith(
        color: fontColor,
      );

    if (fontBold != null && fontBold)
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = SmeupConfigurationService.getTheme()
        .iconTheme
        .copyWith(color: _getElementTextStile().color);

    return themeData;
  }
}
