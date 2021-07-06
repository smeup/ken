import 'package:flutter/material.dart';

class SmeupDashboardNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
