import 'package:flutter/material.dart';

class SmeupScreenNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
