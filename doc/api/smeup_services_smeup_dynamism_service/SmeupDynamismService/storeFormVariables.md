


# storeFormVariables method








void storeFormVariables
([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html) data, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
static void storeFormVariables(Map data, GlobalKey<FormState> formKey) {
  if (data != null && data['name'] != null) {
    String type = data['type'];
    if (type == null || type.toString() != 'sch') {
      SmeupVariablesService.setVariable(data['name'], data['value'] ?? '',
          formKey: null);
    } else {
      SmeupVariablesService.setVariable(data['name'], data['value'] ?? '',
          formKey: formKey);
    }
  }
}
```







