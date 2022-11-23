


# SmeupModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupModel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type})





## Implementation

```dart
SmeupModel(this.formKey, this.scaffoldKey, this.context,
    {this.title, this.id, this.type}) {
  showLoader = SmeupConfigurationService.getAppConfiguration()!.showLoader;
  if (optionsDefault == null) {
    optionsDefault = _getNewLinkedHashMap();
    options = _getNewLinkedHashMap();
    optionsType = _getNewLinkedHashMap();
  }
}
```







