


# Fun constructor




    *[<Null safety>](https://dart.dev/null-safety)*



Fun(dynamic dynamicFun, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context)





## Implementation

```dart
Fun(dynamic dynamicFun, this.formKey, this.scaffoldKey, this.context) {
  _init();

  // the object to parse is empty:
  // - return an empty SmeupFun
  if (dynamicFun == null || dynamicFun.toString().isEmpty) {
    return;
  }

  // the object to parse is a string
  // it could be a Smeup syntax or a json string
  if (dynamicFun is String) {
    // Smeup syntax:
    // - replace the variables
    // - convert it to json object
    if (dynamicFun.startsWith('F(')) {
      _parseFromSmeupSyntax(dynamicFun);
    } else {
      // json string
      // - replace the variables
      // - parse it to json object
      dynamic _fun = jsonDecode(dynamicFun);
      _parseFromJson(_fun);
    }
  } else {
    _parseFromJson(dynamicFun);
  }

  // the object to parse is already a json object:
  // - convert it to string
  // - replace the variables
  // - parse it back to json object

  //_fun = _checkFunElement(_fun);
  saveParametersToVariables(formKey);
}
```







