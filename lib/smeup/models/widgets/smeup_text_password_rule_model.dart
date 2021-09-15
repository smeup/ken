import 'package:flutter/material.dart';

class SmeupTextPasswordRuleModel with ChangeNotifier {
  int satisfiedRules;
  int totalRules;
  //bool isLowerCaseRule;
  //bool isUpperCaseRule;
  bool isNumberRule;
  bool isCharsRule;

  //static String lowerCaseRule = '(?=.*[a-z])';
  //static String upperCaseRule = '(?=.*[A-Z])';
  static String numberRule = '(?=.*[0-9])';
  static String charsRule = '(?=.{8,})';

  // static String passwordRules =
  //     '$lowerCaseRule$upperCaseRule$numberRule$charsRule.*\$';
  static String passwordRules = '$numberRule$charsRule.*\$';

  SmeupTextPasswordRuleModel({
    this.totalRules = 2,
    this.satisfiedRules = 0,
    this.isCharsRule,
    //this.isLowerCaseRule,
    this.isNumberRule,
    //this.isUpperCaseRule
  });

  static bool isPasswordValid(String s) {
    if (s == null) {
      return false;
    }
    if (s.isEmpty) {
      return false;
    }

    RegExp re = RegExp(passwordRules);

    Match firstMatch = re.firstMatch(s);

    if (firstMatch == null) return false;

    return true;
  }

  checkProgress(String password) {
    //isLowerCaseRule = false;
    //isUpperCaseRule = false;
    isNumberRule = false;
    isCharsRule = false;
    satisfiedRules = 0;

    if (password == null) {
      notifyListeners();
      return;
    }
    if (password.isEmpty) {
      notifyListeners();
      return;
    }

    //isLowerCaseRule = _isRuleSadisfied(lowerCaseRule, password);
    //isUpperCaseRule = _isRuleSadisfied(upperCaseRule, password);
    isNumberRule = _isRuleSadisfied(numberRule, password);
    isCharsRule = _isRuleSadisfied(charsRule, password);

    // if (isLowerCaseRule) satisfiedRules += 1;
    // if (isUpperCaseRule) satisfiedRules += 1;
    if (isNumberRule != null && isNumberRule == true) satisfiedRules += 1;
    if (isCharsRule != null && isCharsRule == true) satisfiedRules += 1;

    notifyListeners();
  }

  bool _isRuleSadisfied(String rule, String password) {
    RegExp re = RegExp(rule);
    RegExpMatch match = re.firstMatch(password);
    return match != null;
  }

  void reset() {
    satisfiedRules = 0;
    isCharsRule = null;
    //isLowerCaseRule = null;
    isNumberRule = null;
    //isUpperCaseRule = null;
    notifyListeners();
  }
}
