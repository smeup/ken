import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

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
  final Color? iconColor;
  final double? iconSize;

  static Map<int, String> widgetUniqueIds = {};
  final Uuid uuid = const Uuid();

  String get globallyUniqueId {
    if (!widgetUniqueIds.containsKey(hashCode)) {
      widgetUniqueIds[hashCode] = uuid.v4();
    }
    return widgetUniqueIds[hashCode]!;
  }

  const KenDrawerItem(this.scaffoldKey, this.formKey, this.text, this.route,
      this.iconData, this.action, this.align, this.showItemDivider,
      {super.key,
      this.fontSize,
      this.fontBold,
      this.fontColor,
      this.iconColor,
      this.iconSize});

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
            color: fontColor,
          ),
        if (iconData != null)
          ListTile(
            leading: Icon(
              iconData,
              color: iconColor,
              size: iconSize,
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
    TextStyle style = const TextStyle(backgroundColor: Colors.transparent);

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
}
