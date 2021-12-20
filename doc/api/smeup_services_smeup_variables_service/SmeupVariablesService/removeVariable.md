


# removeVariable method








void removeVariable
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) key, {[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey})








## Implementation

```dart
static void removeVariable(String key, {GlobalKey<FormState> formKey}) {
  if (formKey == null) {
    _globalVariables.remove(key);

    SmeupLogService.writeDebugMessage("Removed the global variable : $key",
        logType: LogType.debug);
  } else {
    _formVariables.remove(key);

    SmeupLogService.writeDebugMessage("Removed the form variable : $key",
        logType: LogType.debug);
  }
}
```







