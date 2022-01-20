


# treatData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic treatData
([SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) model)

_override_






## Implementation

```dart
@override
dynamic treatData(SmeupModel model) {
  SmeupCarouselModel m = model;

  // change data format
  var workData = formatDataFields(m);

  // set the widget data
  if (workData != null) {
    var newList = List<Map>.empty(growable: true);
    for (var i = 0; i < (workData['rows'] as List).length; i++) {
      final element = workData['rows'][i];
      newList.add({
        'imageFile': element['imageFile'].toString(),
        'text': element['text'].toString()
      });
    }
    return newList;
  } else {
    return model.data;
  }
}
```






