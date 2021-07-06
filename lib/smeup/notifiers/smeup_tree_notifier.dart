import 'package:flutter/material.dart';

class SmeupTreeNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
