


# dumpVariables method








void dumpVariables
({[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey})








## Implementation

```dart
static void dumpVariables({GlobalKey<FormState> formKey}) {
  SmeupVariablesService._getJoinMap(formKey: formKey).forEach((key, value) {
    SmeupLogService.writeDebugMessage(
        "Dump variables - Variables status: $key=\"$value\"",
        logType: LogType.debug);
  });
}
```







