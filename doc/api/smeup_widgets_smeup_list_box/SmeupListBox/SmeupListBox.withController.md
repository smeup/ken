


# SmeupListBox.withController constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupListBox.withController([SmeupListBoxModel](../../smeup_models_widgets_smeup_list_box_model/SmeupListBoxModel-class.md) model, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, dynamic parentForm)





## Implementation

```dart
SmeupListBox.withController(SmeupListBoxModel this.model, this.scaffoldKey,
    this.formKey, this.parentForm)
    : super(key: Key(SmeupUtilities.getWidgetId(model.type, model.id))) {
  runControllerActivities(model!);
}
```







