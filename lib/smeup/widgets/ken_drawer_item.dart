import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../services/ken_defaults.dart';

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
  final GlobalKey<ScaffoldState> formKey;
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

  const KenDrawerItem(this.formKey, this.text, this.route, this.iconData,
      this.action, this.align, this.showItemDivider,
      {super.key,
      this.fontSize,
      this.fontBold,
      this.fontColor = KenDrawerDefaults.defaultElementFontColor,
      this.iconColor = KenDrawerDefaults.defaultTitleFontColor,
      this.iconSize});

  @override
  Widget build(BuildContext context) {
    final title = Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
          // i want to pass aligna as left
          alignment: Alignment.centerLeft,
          child: Text(text!, style: _getElementTextStile())),
    );

    function() {
      if (action != null) {
        action!(context);
      }
    }

    return Column(
      children: [
        if (showItemDivider!)
          Divider(
            height: 1.0,
            color: fontColor,
          ),
        if (iconData != null)
          ListTile(
            minVerticalPadding: 0,
            selected: true,
            selectedColor: kBack100,
            visualDensity: VisualDensity.compact,
            dense: true,
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
            minVerticalPadding: 0,
            selected: true,
            selectedColor: kBack100,
            visualDensity: VisualDensity.compact,
            title: title,
            dense: true,
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
