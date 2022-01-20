


# SmeupModel.fromMap constructor







SmeupModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupModel.fromMap(Map<String, dynamic> jsonMap, this.formKey) {
  var myJsonMap = _getNewLinkedHashMap();
  _setLinkedHashMap(jsonMap, myJsonMap);

  type = myJsonMap['type'];
  dynamisms = myJsonMap['dynamisms'];
  smeupFun = SmeupFun(myJsonMap['fun'], formKey);

  switch (myJsonMap['load']) {
    case 'D':
      widgetLoadType = LoadType.Delay;
      break;
    default:
      widgetLoadType = LoadType.Immediate;
  }

  showLoader = myJsonMap['showLoader'] ??
      SmeupConfigurationService.getAppConfiguration().showLoader;
  notificationEnabled = myJsonMap['notification'] ?? true;

  if (type != null && (id == null || id.isEmpty)) {
    id = SmeupUtilities.getWidgetId(myJsonMap['type'], myJsonMap['id']);

    optionsDefault = _getNewLinkedHashMap();
    options = _getNewLinkedHashMap();
    optionsType = _getNewLinkedHashMap();

    if (myJsonMap['options'] != null) {
      _setLinkedHashMap(myJsonMap['options'], options);

      if (myJsonMap['options'][type] != null) {
        _setLinkedHashMap(myJsonMap['options'][type], optionsType);

        if (myJsonMap['options'][type]['default'] != null) {
          _setLinkedHashMap(
              myJsonMap['options'][type]['default'], optionsDefault);
        }
      }
    }
  }

  data = myJsonMap['data'];
}
```






