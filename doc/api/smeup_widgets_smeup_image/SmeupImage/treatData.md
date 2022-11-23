


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
  SmeupImageModel m = model as SmeupImageModel;

  // set the widget data
  bool isRemote = SmeupImageModel.defaultIsRemote;
  dynamic data;
  if (m.data != null &&
      (m.data['rows'] as List).length > 0 &&
      m.data['rows'][0]['code'] != null) {
    String code = m.data['rows'][0]['code'].toString();
    List<String> split = code.split(';');
    if (split.length == 3) {
      String url = split.getRange(2, split.length).join('');
      data = url;
      if (split[0].toString() == 'J1' && split[1].toString() == 'URL')
        isRemote = true;
      else
        isRemote = false;
    } else {
      isRemote = true;
      data = code;
    }
  }

  return {"data": data, "isRemote": isRemote};
}
```







