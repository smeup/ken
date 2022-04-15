


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
  SmeupTreeModel m = model as SmeupTreeModel;

  // change data format
  // ignore: unused_local_variable
  var workData = formatDataFields(m);

  // set the widget data
  // if (workData != null) {
  //   var newList = List<String>.empty(growable: true);
  //   for (var i = 0; i < (workData['rows'] as List).length; i++) {
  //     final element = workData['rows'][i];
  //     newList.add(element[m.valueColName].toString());
  //   }
  //   return newList;
  // } else {
  //   return model.data;
  // }
}
```







