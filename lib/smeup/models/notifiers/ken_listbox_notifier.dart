import 'package:flutter/material.dart';

class KenListBoxNotifier with ChangeNotifier {
  double? height;
  void notifyLoadCompleted(double height) {
    this.height = height;
    notifyListeners();
  }
}
