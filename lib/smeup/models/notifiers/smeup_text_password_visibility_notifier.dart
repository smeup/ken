import 'package:flutter/material.dart';

class SmeupTextPasswordVisibilityNotifier with ChangeNotifier {
  bool _passwordVisible;

  bool get passwordVisible => _passwordVisible;

  set passwordVisible(bool passwordVisible) {
    _passwordVisible = passwordVisible;
    notifyListeners();
  }

  void toggleVisible() {
    _passwordVisible = !passwordVisible;
    notifyListeners();
  }

  SmeupTextPasswordVisibilityNotifier(this._passwordVisible);
}
