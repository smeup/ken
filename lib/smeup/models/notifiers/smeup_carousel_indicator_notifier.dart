import 'package:flutter/material.dart';

class SmeupCarouselIndicatorNotifier with ChangeNotifier {
  int? index;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}
