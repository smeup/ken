import 'package:flutter/material.dart';

class SmeupRadioButtonsNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
