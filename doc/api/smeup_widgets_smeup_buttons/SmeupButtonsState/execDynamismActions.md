


# execDynamismActions method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> execDynamismActions
(dynamic child, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isAsync)








## Implementation

```dart
Future<void> execDynamismActions(dynamic child, bool isAsync) async {
  SmeupDynamismService.storeDynamicVariables(child, widget.formKey);

  if (_model != null) {
    if (isAsync)
      SmeupDynamismService.run(_model!.dynamisms, context, 'click',
          widget.scaffoldKey, widget.formKey);
    else
      await SmeupDynamismService.run(_model!.dynamisms, context, 'click',
          widget.scaffoldKey, widget.formKey);
  }
}
```







