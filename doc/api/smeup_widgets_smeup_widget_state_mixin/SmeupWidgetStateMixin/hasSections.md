


# hasSections method




    *[<Null safety>](https://dart.dev/null-safety)*




[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) hasSections
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)








## Implementation

```dart
bool hasSections(SmeupModel model) {
  return model.smeupSectionsModels != null &&
      model.smeupSectionsModels!.length > 0;
}
```







