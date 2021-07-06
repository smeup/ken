import 'package:flutter/material.dart';

class SmeupTimePickerNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
