


# SmeupImageList.withController constructor







SmeupImageList.withController([SmeupImageListModel](../../smeup_models_widgets_smeup_image_list_model/SmeupImageListModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, dynamic parentForm)





## Implementation

```dart
SmeupImageList.withController(
    this.model, this.scaffoldKey, this.formKey, this.parentForm)
    : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model);
}
```







