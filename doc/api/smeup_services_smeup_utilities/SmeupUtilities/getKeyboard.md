


# getKeyboard method




    *[<Null safety>](https://dart.dev/null-safety)*




[TextInputType](https://api.flutter.dev/flutter/services/TextInputType-class.html) getKeyboard
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? keyboard)








## Implementation

```dart
static TextInputType getKeyboard(String? keyboard) {
  switch (keyboard) {
    case "datetime":
      return TextInputType.datetime;
    case "emailAddress":
      return TextInputType.emailAddress;
    case "multiline":
      return TextInputType.multiline;
    case "name":
      return TextInputType.name;
    case "number":
      return TextInputType.number;
    case "phone":
      return TextInputType.phone;
    case "streetAddress":
      return TextInputType.streetAddress;
    case "text":
      return TextInputType.text;
    case "url":
      return TextInputType.url;
    case "visiblePassword":
      return TextInputType.visiblePassword;
    default:
      return TextInputType.text;
  }
}
```







