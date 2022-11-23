import 'package:flutter/material.dart';

class KenCarouselIndicatorNotifier with ChangeNotifier {
  int? index;
  void setIndex(int value) {
    index = value;
    notifyListeners();
  }
}
