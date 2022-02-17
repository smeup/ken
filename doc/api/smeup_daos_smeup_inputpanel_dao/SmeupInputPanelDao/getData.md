


# getData method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> getData
([SmeupInputPanelModel](../../smeup_models_widgets_smeup_inputpanel_model/SmeupInputPanelModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)

_override_






## Implementation

```dart
static Future<void> getData(
    SmeupInputPanelModel model,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context) async {
  await SmeupDao.getData(model, executeDecrementDataFetch: false);

  List columns = model.data["columns"];
  Map rowFields = model.data["rows"][0];

  model.fields = _createFields(columns, rowFields);

  var layoutData =
      await _getLayoutData(model.options, formKey, scaffoldKey, context);
  if (layoutData != null) {
    await _applyLayout(
        model.fields, layoutData["data"], formKey, scaffoldKey, context);
  }
  SmeupDataService.decrementDataFetch(model.id);
}
```







