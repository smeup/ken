import 'package:flutter/material.dart';

class SmeupDrawerDataElement {
  String? text;
  String? route;
  dynamic iconCode;
  double fontSize;
  String group;
  int groupIcon;
  double groupFontSize;
  Alignment align;
  Function? action;

  SmeupDrawerDataElement(this.text,
      {this.iconCode,
      this.fontSize = 10,
      this.align = Alignment.center,
      this.route,
      this.action,
      this.group = '',
      this.groupIcon = 0,
      this.groupFontSize = 15});
}
