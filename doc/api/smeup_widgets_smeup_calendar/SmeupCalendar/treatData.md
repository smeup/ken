


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
  SmeupCalendarModel m = model as SmeupCalendarModel;

  // change data format
  var workData = m.data;
  // formatDataFields(m);

  // set the widget data
  if (workData != null) {
    List<Map<String, dynamic>> newList =
        List<Map<String, dynamic>>.empty(growable: true);
    for (var i = 0; i < (workData['rows'] as List).length; i++) {
      final element = workData['rows'][i];
      newList.add({
        m.dataColumnName: element[m.dataColumnName],
        m.initTimeColumnName: element[m.initTimeColumnName],
        m.endTimeColumnName: element[m.endTimeColumnName],
        m.titleColumnName: element[m.titleColumnName],
        m.styleColumnName: element[m.styleColumnName],
        "datarow": element
      });
    }
    return newList;
  } else {
    return model.data;
  }
}
```







