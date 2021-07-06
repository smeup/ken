import 'package:flutter/material.dart';

class SmeupQRCodeReaderNotifier with ChangeNotifier {
  void changeWidgets(widgetId) {
    notifyListeners();
  }
}
