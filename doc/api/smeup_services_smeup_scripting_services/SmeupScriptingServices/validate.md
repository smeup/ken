


# validate method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) validate
({required [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, required [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, required [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) screenId, required [String](https://api.flutter.dev/flutter/dart-core/String-class.html) script})








## Implementation

```dart
static bool validate(
    {required BuildContext context,
    required GlobalKey<FormState> formKey,
    required GlobalKey<ScaffoldState> scaffoldKey,
    required String screenId,
    required String script}) {
  if (script.isEmpty) return true;
  Map jsMap = Map();
  SmeupVariablesService.getVariables(formKey: formKey).forEach((key, value) {
    jsMap[key
        .toString()
        .replaceFirst(formKey.hashCode.toString() + "_", "")] = value;
  });

  JsEvalResult _result =
      _createScriptingRuntime(context, formKey, scaffoldKey).evaluate(
          "validate('$screenId', JSON.parse('${json.encode(jsMap)}'));" +
              script);

  if (_result.isError) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error on js evaluation ${_result.stringResult}")));
    return false;
  } else {
    return _result.stringResult == "true";
  }
}
```







