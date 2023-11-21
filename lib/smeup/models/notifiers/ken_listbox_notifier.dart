import 'package:flutter/material.dart';

class KenListBoxNotifier with ChangeNotifier {
  void notifyLoadCompleted() {
    notifyListeners();
  }
}
