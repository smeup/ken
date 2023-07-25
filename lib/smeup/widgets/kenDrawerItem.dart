import 'package:flutter/material.dart';

import '../services/ken_configuration_service.dart';
import 'globallyUniqueIdExtension.dart';

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

  static Map<int, String> widgetUniqueIds = {};
  String get globallyUniqueId {
    if (!widgetUniqueIds.containsKey(hashCode)) {
      widgetUniqueIds[hashCode] = uuid.v4();
    }
    return widgetUniqueIds[hashCode]!;
  }

  const KenDrawerItem(this.scaffoldKey, this.formKey, this.text, this.route,
      this.iconData, this.action, this.align, this.showItemDivider,
      {super.key, this.fontSize, this.fontBold, this.fontColor});

  @override
  Widget build(BuildContext context) {
    final title = Align(
        alignment: align, child: Text(text!, style: _getElementTextStile()));

    function() {
      if (action != null) {
        action!(context);
      }
    }

    return Column(
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
            onTap: function,
          )
        else
          ListTile(
            title: title,
            onTap: function,
          ),
      ],
    );
  }

  TextStyle _getElementTextStile() {
    TextStyle style = KenConfigurationService.getTheme()!
        .appBarTheme
        .toolbarTextStyle!
        .copyWith(
            backgroundColor: KenConfigurationService.getTheme()!
                .appBarTheme
                .backgroundColor);

    if (fontSize != null) {
      style = style.copyWith(
        fontSize: fontSize,
      );
    }

    if (fontColor != null) {
      style = style.copyWith(
        color: fontColor,
      );
    }

    if (fontBold != null && fontBold!) {
      style = style.copyWith(
        fontWeight: FontWeight.bold,
      );
    }

    return style;
  }

  IconThemeData _getIconTheme() {
    IconThemeData themeData = KenConfigurationService.getTheme()!
        .appBarTheme
        .iconTheme!
        .copyWith(color: _getElementTextStile().color);

    return themeData;
  }
}
