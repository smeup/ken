import 'package:flutter/material.dart';
import 'package:ken/smeup/widgets/ken_label.dart';

class ShowCaseShared {
  static getTestLabel(_scaffoldKey, _formKey, text, {double height: 30}) {
    return KenLabel(
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
