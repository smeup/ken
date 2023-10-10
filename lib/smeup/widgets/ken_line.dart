import 'package:flutter/material.dart';
import '../models/widgets/ken_line_model.dart';
import '../services/ken_defaults.dart';

// ignore: must_be_immutable
class KenLine extends StatelessWidget {
  KenLineModel? model;
  GlobalKey<ScaffoldState> scaffoldKey;
  GlobalKey<FormState>? formKey;

  Color? color;
  double? thickness;
  String? title;
  String? id;
  String? type;

  dynamic data;

  KenLine(this.scaffoldKey, this.formKey,
      {super.key,
      this.title,
      this.id = '',
      this.type = 'LIN',
      this.color = KenLineDefault.defaultColor,
      this.thickness = KenLineDefault.defaultThickness});

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
