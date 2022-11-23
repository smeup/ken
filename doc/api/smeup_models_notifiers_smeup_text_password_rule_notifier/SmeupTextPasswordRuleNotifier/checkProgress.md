


# checkProgress method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic checkProgress
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) password)








## Implementation

```dart
checkProgress(String password) {
  rules.forEach((rule) {
    rule['isValid'] = false;
  });

  satisfiedRules = 0;

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
```







