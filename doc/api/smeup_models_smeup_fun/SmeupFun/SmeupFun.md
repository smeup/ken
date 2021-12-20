


# SmeupFun constructor







SmeupFun(dynamic dynamicFun, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey)





## Implementation

```dart
SmeupFun(dynamic dynamicFun, this.formKey) {
  // the object to parse is empty:
  // - return an empty SmeupFun
  if (dynamicFun == null || dynamicFun.toString().isEmpty) {
    fun = Map();
    fun['fun'] = Map();
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
      fun = jsonDecode(dynamicFun);
    }
  } else {
    fun = dynamicFun;
  }

  // the object to parse is already a json object:
  // - convert it to string
  // - replace the variables
  // - parse it back to json object
  fun = _checkFunElement(fun);
  saveParameters(formKey);
}
```







