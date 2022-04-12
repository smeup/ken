


# removeFormVariables method




    *[<Null safety>](https://dart.dev/null-safety)*




void removeFormVariables
([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
static void removeFormVariables(GlobalKey<FormState> formKey) {
  SmeupVariablesService._formVariables.removeWhere(
      (key, value) => key.toString().startsWith(formKey.hashCode.toString()));

  SmeupLogService.writeDebugMessage(
      "Removed all form variables : ${formKey.hashCode}",
      logType: LogType.debug);
}
```







