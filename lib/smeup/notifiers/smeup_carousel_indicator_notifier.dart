import 'package:flutter/material.dart';

class SmeupCaurouselModelIndicatorNotifier with ChangeNotifier {
  int index;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}
