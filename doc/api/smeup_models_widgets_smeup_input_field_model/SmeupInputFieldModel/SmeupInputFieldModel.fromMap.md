


# SmeupInputFieldModel.fromMap constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupInputFieldModel.fromMap([Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), dynamic> jsonMap, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [SmeupModel](../../smeup_models_widgets_smeup_model/SmeupModel-class.md) parent)





## Implementation

```dart
SmeupInputFieldModel.fromMap(
    Map<String, dynamic> jsonMap,
    GlobalKey<FormState>? formKey,
    GlobalKey<ScaffoldState>? scaffoldKey,
    BuildContext? context,
    SmeupModel parent)
    : super.fromMap(
        jsonMap,
        formKey,
        scaffoldKey,
        context,
      ) {
  this.parent = parent;

  validation = optionsDefault!['validation'];
  validationField =
      optionsDefault!['validationField'] ?? defaultValidationField;
  validationFun = jsonMap['validation'] != null
      ? Fun(jsonMap['validation'], formKey, scaffoldKey, context)
      : null;

  _addFieldPathToFun(validationFun);
  _addFieldPathToFun(smeupFun);

  SmeupInputFieldDao.getValidation(this);
}
```







