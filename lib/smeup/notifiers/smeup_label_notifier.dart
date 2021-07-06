import 'package:flutter/material.dart';

class SmeupLabelNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
