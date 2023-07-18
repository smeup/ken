import 'package:flutter/material.dart';

class KenTextPasswordRuleNotifier with ChangeNotifier {
  late int satisfiedRules;
  late int totalRules;
  static String passwordRules = '';

  List<dynamic> rules;

  KenTextPasswordRuleNotifier(
    this.rules,
  ) {
    totalRules = rules.length;
    satisfiedRules = 0;
    passwordRules = '';
    for (var rule in rules) {
      passwordRules += rule['regex'].toString();
    }
    passwordRules += '.*\$';
  }

  static bool isPasswordValid(String password) {
    if (password.isEmpty) {
      return false;
    }

    RegExp re = RegExp(passwordRules);

    Match? firstMatch = re.firstMatch(password);

    if (firstMatch == null) return false;

    return true;
  }

  checkProgress(String password) {
    for (var rule in rules) {
      rule['isValid'] = false;
    }

    satisfiedRules = 0;

    if (password.isEmpty) {
      notifyListeners();
      return;
    }

    for (var rule in rules) {
      rule['isValid'] = _isRuleSadisfied(rule['regex'], password);
      if (rule['isValid']) satisfiedRules += 1;
    }

    notifyListeners();
  }

  bool _isRuleSadisfied(String rule, String password) {
    RegExp re = RegExp(rule);
    RegExpMatch? match = re.firstMatch(password);
    return match != null;
  }

  void reset() {
    satisfiedRules = 0;
    for (var rule in rules) {
      rule['isValid'] = false;
    }
    notifyListeners();
  }
}
