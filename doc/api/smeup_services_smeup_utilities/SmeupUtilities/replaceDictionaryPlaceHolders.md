


# replaceDictionaryPlaceHolders method




    *[<Null safety>](https://dart.dev/null-safety)*




[String](https://api.flutter.dev/flutter/dart-core/String-class.html) replaceDictionaryPlaceHolders
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) source)








## Implementation

```dart
static String replaceDictionaryPlaceHolders(String source) {
  String workString = source;
  if (SmeupConfigurationService.appDictionary != null) {
    RegExp re = RegExp(r'\{\{.*\}\}');
    re.allMatches(source).forEach((match) {
      final placeHolder = source.substring(match.start, match.end);
      if (placeHolder.isNotEmpty) {
        final dictionaryKey =
            placeHolder.replaceFirst('{{', '').replaceFirst('}}', '');

        if (SmeupConfigurationService.appDictionary
                .getLocalString(dictionaryKey) !=
            null) {
          workString = workString.replaceAll(
              placeHolder,
              SmeupConfigurationService.appDictionary
                  .getLocalString(dictionaryKey));
        }
      }
    });
  }

  return workString;
}
```







