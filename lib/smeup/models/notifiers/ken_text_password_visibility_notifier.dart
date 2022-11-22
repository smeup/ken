import 'package:flutter/material.dart';

class KenTextPasswordVisibilityNotifier with ChangeNotifier {
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

  KenTextPasswordVisibilityNotifier(this._passwordVisible);
}
