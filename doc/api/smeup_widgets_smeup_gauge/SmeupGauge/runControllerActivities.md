


# runControllerActivities method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic runControllerActivities
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
runControllerActivities(SmeupModel model) {
  SmeupGaugeModel m = model;
  id = m.id;
  type = m.type;
  title = m.title;
  valueColName = m.valueColName;
  maxColName = m.maxColName;
  minColName = m.minColName;
  warningColName = m.warningColName;

  treatData(m);
}
```







