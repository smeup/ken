


# SmeupModel constructor







SmeupModel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) id, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type})





## Implementation

```dart
SmeupModel(this.formKey, {this.title, this.id, this.type}) {
  showLoader = SmeupConfigurationService.getAppConfiguration().showLoader;
  if (optionsDefault == null) {
    optionsDefault = _getNewLinkedHashMap();
    options = _getNewLinkedHashMap();
    optionsType = _getNewLinkedHashMap();
  }
}
```







