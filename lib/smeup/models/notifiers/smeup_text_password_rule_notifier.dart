import 'package:flutter/material.dart';

class SmeupTextPasswordRuleNotifier with ChangeNotifier {
  int satisfiedRules;
  int totalRules;
  static String passwordRules = '';

  List<dynamic> rules;

  SmeupTextPasswordRuleNotifier(
    this.rules,
  ) {
    this.totalRules = rules.length;
    this.satisfiedRules = 0;
    passwordRules = '';
    rules.forEach((rule) {
      passwordRules += "${rule['regex'].toString()}";
    });
    passwordRules += '.*\$';
  }

  static bool isPasswordValid(String password) {
    if (password == null) {
      return false;
    }
    if (password.isEmpty) {
      return false;
    }

    RegExp re = RegExp(passwordRules);

    Match firstMatch = re.firstMatch(password);

    if (firstMatch == null) return false;

    return true;
  }

  checkProgress(String password) {
    rules.forEach((rule) {
      rule['isValid'] = false;
    });

    satisfiedRules = 0;

    if (password == null) {
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      notifyListeners();
      return;
    }

    rules.forEach((rule) {
      rule['isValid'] = _isRuleSadisfied(rule['regex'], password);
      if (rule['isValid']) satisfiedRules += 1;
    });

    notifyListeners();
  }

  bool _isRuleSadisfied(String rule, String password) {
    RegExp re = RegExp(rule);
    RegExpMatch match = re.firstMatch(password);
    return match != null;
  }

  void reset() {
    satisfiedRules = 0;
    rules.forEach((rule) {
      rule['isValid'] = false;
    });
    notifyListeners();
  }
}
