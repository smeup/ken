


# SmeupWaitModel constructor







SmeupWaitModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) splashColor, dynamic title = ''})





## Implementation

```dart
SmeupWaitModel(
    {id, type, GlobalKey<FormState> formKey, this.splashColor, title = ''})
    : super(formKey, title: title, id: id, type: type) {
  if (optionsDefault['type'] == null) optionsDefault['type'] = 'wai';
  SmeupDataService.incrementDataFetch(id);
}
```







