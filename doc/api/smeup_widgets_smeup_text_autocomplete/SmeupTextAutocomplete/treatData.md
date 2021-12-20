


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupTextAutocompleteModel m = model;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null) {
    var newList = List<dynamic>.empty(growable: true);
    for (var i = 0; i < (workData['rows'] as List).length; i++) {
      final element = workData['rows'][i];
      newList.add({
        'code': element['code'].toString(),
        'value': element['value'].toString()
      });
    }
    return newList;
  } else {
    return model.data;
  }
}
```







