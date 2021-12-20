


# saveParameters method








void saveParameters
([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)








## Implementation

```dart
void saveParameters(GlobalKey<FormState> formKey) {
  List<Map<String, dynamic>> list = getParameters();
  list.forEach((element) {
    SmeupVariablesService.setVariable(element['key'], element['value'],
        formKey: formKey);
  });
}
```







