


# replaceFunVariables method








[String](https://api.flutter.dev/flutter/dart-core/String-class.html) replaceFunVariables
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) funString, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
static String replaceFunVariables(
    String funString, GlobalKey<FormState> formKey) {
  SmeupVariablesService.getVariables(formKey: formKey)
      .entries
      .forEach((element) {
    String key = element.key;
    if (formKey != null)
      key = key.replaceAll('${formKey.hashCode.toString()}_', '');

    if (element.value is String) {
      funString =
          funString.replaceAll('[$key]', element.value.toString() ?? '');
    } else {
      funString =
          funString.replaceAll('\"[$key]\"', element.value.toString() ?? '');
    }
  });
  try {
    // remove not replacable variable
    RegExp re = RegExp(r'\[[^\]]*\]');
    String newFun = funString;
    re.allMatches(funString).forEach((match) {
      final value = funString
          .substring(match.start, match.end)
          .replaceFirst('[', '')
          .replaceFirst(']', '');
      if (value != null && value.isNotEmpty) {
        newFun = newFun.replaceAll('[$value]', '');
        SmeupLogService.writeDebugMessage(
            'removed the parameter: $value in replaceFunVariables',
            logType: LogType.warning);
      }
    });
    funString = newFun;
  } catch (e) {
    SmeupLogService.writeDebugMessage(
        'Error in replaceFunVariables: $funString ',
        logType: LogType.error);
  }
  return funString;
}
```







