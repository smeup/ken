


# isPasswordValid method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isPasswordValid
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) password)








## Implementation

```dart
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
```







