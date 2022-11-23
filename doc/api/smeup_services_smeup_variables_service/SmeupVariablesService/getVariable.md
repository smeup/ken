


# getVariable method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic getVariable
([String](https://api.flutter.dev/flutter/dart-core/String-class.html)? key, {[GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey})








## Implementation

```dart
static dynamic getVariable(String? key, {GlobalKey<FormState>? formKey}) {
  var value = _formVariables['${formKey.hashCode.toString()}_$key'];
  if (value == null) {
    value = _globalVariables[key];
  }
  return value;
}
```







