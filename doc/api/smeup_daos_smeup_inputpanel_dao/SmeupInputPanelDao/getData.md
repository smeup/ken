


# getData method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupInputPanelModel](../../smeup_models_widgets_smeup_input_panel_model/SmeupInputPanelModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)

_override_






## Implementation

```dart
static Future<void> getData(
    SmeupInputPanelModel model,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context) async {
  await SmeupDao.getData(model, executeDecrementDataFetch: false);

  List columns = model.data["columns"];
  Map? row = model.data["rows"][0];

  var layoutData =
      await _getLayoutData(model.options!, formKey, scaffoldKey, context);

  model.fields = await _createFields(
      columns, row, formKey, scaffoldKey, context, layoutData, model);

  if (layoutData != null) {
    await _applyLayout(
        model.fields!, layoutData["data"], formKey, scaffoldKey, context);
  }
  model.fields!.sort((a, b) => a.position.compareTo(b.position));
  SmeupDataService.decrementDataFetch(model.id);
}
```







