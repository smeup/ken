import 'package:flutter/material.dart';

class SmeupChartNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
