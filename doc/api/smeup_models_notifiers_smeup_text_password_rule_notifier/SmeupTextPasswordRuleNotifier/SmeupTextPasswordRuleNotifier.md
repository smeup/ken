


# SmeupTextPasswordRuleNotifier constructor







SmeupTextPasswordRuleNotifier([List](https://api.flutter.dev/flutter/dart-core/List-class.html) rules)





## Implementation

```dart
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
```







