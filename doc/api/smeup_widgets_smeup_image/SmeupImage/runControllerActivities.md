


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupImageModel m = model;
  id = m.id;
  type = m.type;
  padding = m.padding;
  width = m.width;
  height = m.height;
  title = m.title;

  var res = treatData(m);
  data = res['data'];
  isRemote = res['isRemote'];
}
```







