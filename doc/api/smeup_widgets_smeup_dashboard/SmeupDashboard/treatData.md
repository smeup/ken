


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
  SmeupDashboardModel m = model as SmeupDashboardModel;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null &&
      (workData['rows'] as List).length > 0 &&
      workData['rows'][0][m.valueColName] != null) {
    data = SmeupUtilities.getDouble(workData['rows'][0][m.valueColName]);
    unitOfMeasure = workData['rows'][0][m.umColName];
    text = workData['rows'][0][m.textColName];
    icon = SmeupUtilities.getInt(workData['rows'][0][m.iconColName]);
  }

  if (m.forceText!.isNotEmpty) {
    text = m.forceText;
  }

  if (m.forceIcon!.isNotEmpty) {
    icon = m.forceIcon as int?;
  }

  if (m.forceUm!.isNotEmpty) {
    unitOfMeasure = m.forceUm;
  }

  if (m.forceValue!.isNotEmpty) {
    data = m.forceValue as double?;
  }

  return data;
}
```







