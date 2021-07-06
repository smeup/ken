import 'package:flutter/material.dart';

class SmeupFieldNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
