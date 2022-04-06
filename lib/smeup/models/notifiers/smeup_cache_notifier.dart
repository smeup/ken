import 'package:flutter/material.dart';

class SmeupCacheNotifier with ChangeNotifier {
  bool? _isOnline;
  bool? get isOnline => _isOnline;
  set isOnline(bool? isOnline) {
    _isOnline = isOnline;
    notifyListeners();
  }

  SmeupCacheNotifier() {
    _isOnline = true;
  }
}
