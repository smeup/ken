


# getLocalString method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) getLocalString
(dynamic stringCode)








## Implementation

```dart
String getLocalString(stringCode) {
  var localString = _localizedValues[locale.languageCode]![stringCode];

  if (localString != null) {
    return localString;
  } else {
    return stringCode;
  }
}
```







