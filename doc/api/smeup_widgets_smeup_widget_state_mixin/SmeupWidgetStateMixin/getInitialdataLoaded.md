


# getInitialdataLoaded method








[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) getInitialdataLoaded
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)





<p>return the information if data has been loaded
static constructor: always false (because in this case the widget will receive the data directly)
dynamic constrctor: true if the model is not null and contains data</p>



## Implementation

```dart
bool getInitialdataLoaded(SmeupModel model) {
  return (model != null && model.data != null) || model == null;
}
```







