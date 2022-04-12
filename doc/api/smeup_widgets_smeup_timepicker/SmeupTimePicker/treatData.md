


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
  // change data format
  final workData = formatDataFields(model);

  String? display;
  DateTime value;

  final now = DateTime.now();

  if (workData != null) {
    final valueString = workData['rows'][0][valueField];
    final split = valueString.split(':');
    value = DateTime.parse(
        '${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${split[0]}:${split[1]}:00');

    display = workData['rows'][0][displayField];
  } else {
    value = now;
    display = DateFormat('HH:mm').format(value);
  }

  return SmeupTimePickerData(time: value, formattedTime: display);
}
```







