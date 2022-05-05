


# validate method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)> validate
({required [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, required [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)? field, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? script})








## Implementation

```dart
static Future<bool> validate(
    {required BuildContext context,
    GlobalKey<FormState>? formKey,
    required GlobalKey<ScaffoldState> scaffoldKey,
    Map? field,
    String? script}) async {
  if (formKey == null || field == null || script == null) {
    SmeupLogService.writeDebugMessage(
        "Unable to validate because formKey or fieldId or script is not specified",
        logType: LogType.error);
    return false;
  }
  JavascriptRuntime js = _createRuntime(
      context: context, formKey: formKey, scaffoldKey: scaffoldKey);

  Map jsMap = Map();
  SmeupVariablesService.getVariables(formKey: formKey).forEach((key, value) {
    jsMap[key
        .toString()
        .replaceFirst(formKey.hashCode.toString() + "_", "")] = value;
  });
  field["value"] = jsMap[field["code"]];

  var code = """
      $script
      validate(JSON.parse('${json.encode(field)}'), JSON.parse('${json.encode(jsMap)}'));
      """;

  var asyncResult = await js.evaluateAsync(code);
  if (asyncResult.isError) {
    _logError(context, asyncResult.stringResult, code);
  }
  js.executePendingJob();
  try {
    return (await js.handlePromise(asyncResult)).stringResult == "true";
  } catch (err) {
    _logError(context, err.toString(), code);
    return false;
  }
}
```







