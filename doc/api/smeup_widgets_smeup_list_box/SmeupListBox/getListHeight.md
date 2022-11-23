


# getListHeight method




    *[<Null safety>](https://dart.dev/null-safety)*




[double](https://api.flutter.dev/flutter/dart-core/double-class.html)? getListHeight
([double](https://api.flutter.dev/flutter/dart-core/double-class.html)? widgetListHeight, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md)? model, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context)








## Implementation

```dart
static double? getListHeight(
    double? widgetListHeight, SmeupModel? model, BuildContext context) {
  double? listboxHeight = widgetListHeight;
  if (model != null && model.parent != null) {
    if (listboxHeight == 0)
      listboxHeight = (model.parent as SmeupSectionModel).height;
  } else {
    if (listboxHeight == 0)
      listboxHeight = SmeupUtilities.getDeviceInfo().safeHeight;
  }
  return listboxHeight;
}
```







