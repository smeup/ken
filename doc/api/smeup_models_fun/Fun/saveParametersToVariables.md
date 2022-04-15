


# saveParametersToVariables method




    *[<Null safety>](https://dart.dev/null-safety)*




void saveParametersToVariables
([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey)








## Implementation

```dart
void saveParametersToVariables(GlobalKey<FormState>? formKey) {
  parameters.forEach((element) {
    SmeupVariablesService.setVariable(element['key'], element['value'],
        formKey: formKey);
  });
}
```







