


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
  SmeupDatePickerModel m = model as SmeupDatePickerModel;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null && (workData['rows'] as List).length > 0) {
    DateTime? value;
    String? text;
    if (workData['rows'][0][valueField] != null) {
      value = DateFormat('dd/MM/yyyy').parse(workData['rows'][0][valueField]);
    }
    if (workData['rows'][0][displayField] != null) {
      text = workData['rows'][0][displayField];
    }
    return SmeupDatePickerData(value: value, text: text);
  } else {
    return model.data;
  }
}
```







