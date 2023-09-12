import 'package:flutter/material.dart';

class KenDrawerDataElement {
  String? text;
  String? route;
  dynamic iconCode;
  double fontSize;
  String group;
  String groupIcon;
  double groupFontSize;
  Alignment align;
  Function? action;

  IconData? groupIconData;
  IconData? itemIconData;

  KenDrawerDataElement(this.text,
      {this.iconCode,
      this.fontSize = 14,
      this.align = Alignment.center,
      this.route,
      this.action,
      this.group = '',
      this.groupIcon = '',
      this.groupFontSize = 16});
}
