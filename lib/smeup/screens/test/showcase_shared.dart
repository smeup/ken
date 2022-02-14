import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/smeup_label.dart';

class ShowCaseShared {
  static getTestLabel(_scaffoldKey, _formKey, text, {double height: 15}) {
    return SmeupLabel(
      _scaffoldKey,
      _formKey,
      [text],
      height: height,
    );
  }

  static getEmptyAction() {
    return [
      SizedBox(
        width: 56,
      )
    ];
  }
}
