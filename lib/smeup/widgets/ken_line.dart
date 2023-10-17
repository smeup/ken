import 'package:flutter/material.dart';
import '../services/ken_defaults.dart';

class KenLine extends StatelessWidget {
  final Color? color;
  final double? thickness;
  final String? title;
  final String? id;
  final String? type;

  final dynamic data;

  const KenLine(
      {super.key,
      this.title,
      this.id = '',
      this.type = 'LIN',
      this.color = KenLineDefaults.defaultColor,
      this.thickness = KenLineDefaults.defaultThickness,
      this.data});

  @override
  Widget build(BuildContext context) {
    DividerThemeData captionStyle = _getDividerStile();

    return Divider(
      color: captionStyle.color,
      thickness: captionStyle.thickness,
    );
  }

  DividerThemeData _getDividerStile() {
    DividerThemeData dividerData =
        DividerThemeData(color: color, thickness: thickness);

    return dividerData;
  }
}
