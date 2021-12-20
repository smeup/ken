


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupListBoxModel m = model;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null) {
    // Manage columns setup field: hide column if isn't in the set of columns
    if (m.visibleColumns.isNotEmpty) {
      for (var i = 0; i < (workData['columns'] as List).length; i++) {
        final column = workData['columns'][i];
        if (m.visibleColumns.contains(column['code']) == false) {
          column['IO'] = 'H';
        }
      }
      return workData;
    } else {
      return workData;
    }
  } else {
    return model.data;
  }
}
```







