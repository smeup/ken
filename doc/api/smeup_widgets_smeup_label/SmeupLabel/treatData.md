


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
  SmeupLabelModel m = model as SmeupLabelModel;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null) {
    var newList = List<String>.empty(growable: true);

    // overrides model properties from data
    var firstElement = (workData['rows'] as List).first;
    if (firstElement != null) {
      if (firstElement[m.optionsDefault!['iconColName']] != null) {
        m.iconData = SmeupUtilities.getInt(
                firstElement[m.optionsDefault!['iconColName']]) ??
            0;
      }

      if (firstElement[m.optionsDefault!['backColorColName']] != null) {
        m.backColor = SmeupUtilities.getColorFromRGB(
            firstElement[m.optionsDefault!['backColorColName']]);
      }

      if (firstElement[m.optionsDefault!['fontColorColName']] != null) {
        m.fontColor = SmeupUtilities.getColorFromRGB(
            firstElement[m.optionsDefault!['fontColorColName']]);
      }
    }

    for (var i = 0; i < (workData['rows'] as List).length; i++) {
      final element = workData['rows'][i];
      newList.add(element[m.valueColName].toString());
    }
    return newList;
  } else {
    return model.data;
  }
}
```







