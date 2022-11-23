import 'package:flutter/material.dart';

bool _isError = false;

class KenErrorNotifier with ChangeNotifier {
  void notifyError() {
    _isError = true;
    notifyListeners();
  }

  bool isError() {
    return _isError;
  }

  void setError(bool value) {
    _isError = value;
  }

  void reset() {
    _isError = false;
  }
}
