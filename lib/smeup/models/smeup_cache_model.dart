import 'package:flutter/material.dart';

class SmeupCacheModel with ChangeNotifier {
  bool _isOnline;
  bool get isOnline => _isOnline;
  set isOnline(bool isOnline) {
    _isOnline = isOnline;
    notifyListeners();
  }

  SmeupCacheModel() {
    _isOnline = true;
  }
}
