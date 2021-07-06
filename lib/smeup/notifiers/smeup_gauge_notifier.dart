import 'package:flutter/material.dart';

class SmeupGaugeNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
