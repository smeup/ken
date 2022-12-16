import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/kenEnumCallback.dart';
import '../services/ken_configuration_service.dart';

// ignore: must_be_immutable
class KenDrawerItem extends StatelessWidget {
  final String? text;
  final String? route;
  //final dynamic iconCode;
  final Function? action;
  final double? fontSize;
  final Color? fontColor;
  final bool? fontBold;
  final Alignment align;
  final bool? showItemDivider;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final GlobalKey<FormState> formKey;
  final IconData? iconData;

  Function(dynamic, KenCallbackType, dynamic)? callBack;

  KenDrawerItem(this.scaffoldKey, this.formKey, this.text, this.route,
      this.iconData, this.action, this.align, this.showItemDivider,
      {this.fontSize, this.fontBold, this.fontColor, this.callBack});

  @override
  Widget build(BuildContext context) {
    final title = Align(
        alignment: align, child: Text(text!, style: _getElementTextStile()));

    Function function = () {
      if (action != null) {
        action!(context);
      } else {
        if (route!.trimLeft().toUpperCase().startsWith('F(')) {
          if (callBack != null) {
            callBack!(null, KenCallbackType.onTap, route);
          }
        } else {
          Navigator.of(context).pushNamed(route!);
        }
      }
    };

    return Container(
        child: Column(
      children: [
        if (showItemDivider!)
          Divider(
            color: _getElementTextStile().color,
          ),
        if (iconData != null)
          ListTile(
            leading: Icon(
              iconData,
              color: _getIconTheme().color,
              size: _getIconTheme().size,
            ),
            title: title,
            onTap: function as void Function()?,
          )
        else
          ListTile(
            title: title,
            onTap: function as void Function()?,
          ),
      ],
    ));
  }

  TextStyle _getElementTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!
        .appBarTheme
        .toolbarTextStyle!
        .copyWith(
            backgroundColor: KenConfigurationService.getTheme()!
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

    if (fontBold != null && fontBold!)
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .iconTheme
        .copyWith(color: _getElementTextStile().color);

    return themeData;
  }
}
