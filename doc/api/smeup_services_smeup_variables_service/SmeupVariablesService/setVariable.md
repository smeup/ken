


# setVariable method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setVariable
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? key, dynamic value, {[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey})








## Implementation

```dart
static setVariable(String? key, dynamic value,
    {GlobalKey<FormState>? formKey}) {
  var workKey = key;
  if (formKey == null) {
    _globalVariables[workKey] = value;

    if (_globalVariables[workKey] == null) {
      SmeupLogService.writeDebugMessage(
          "Added the global variable : $workKey, value: $value",
          logType: LogType.debug);
    } else {
      SmeupLogService.writeDebugMessage(
          "Changed the global variable : $workKey, value: $value",
          logType: LogType.debug);
    }
  } else {
    workKey = '${formKey.hashCode.toString()}_$key';

    _formVariables[workKey] = value;

    if (_formVariables[workKey] == null) {
      SmeupLogService.writeDebugMessage(
          "Added the form variable : $workKey, value: $value",
          logType: LogType.debug);
    } else {
      SmeupLogService.writeDebugMessage(
          "Changed the form variable : $workKey, value: $value",
          logType: LogType.debug);
    }
  }
}
```







