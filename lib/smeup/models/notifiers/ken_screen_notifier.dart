import 'package:flutter/material.dart';

class KenScreenNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
