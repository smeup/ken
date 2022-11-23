


# treatData method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupChartModel m = model as SmeupChartModel;

  // change data format
  var workData = formatDataFields(m);

  final smeupChartDatasource = SmeupChartDatasource.fromMap(workData);
  return smeupChartDatasource;
}
```







