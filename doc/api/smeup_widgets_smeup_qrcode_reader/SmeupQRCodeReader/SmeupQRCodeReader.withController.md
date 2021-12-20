


# SmeupQRCodeReader.withController constructor







SmeupQRCodeReader.withController([SmeupQRCodeReaderModel](../../smeup_models_widgets_smeup_qrcode_reader_model/SmeupQRCodeReaderModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupQRCodeReader.withController(
  this.model,
  this.scaffoldKey,
  this.formKey,
) : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model);
}
```







