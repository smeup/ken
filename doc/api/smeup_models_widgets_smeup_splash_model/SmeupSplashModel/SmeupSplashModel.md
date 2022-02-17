


# SmeupSplashModel constructor







SmeupSplashModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, dynamic title = ''})





## Implementation

```dart
SmeupSplashModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.color,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (optionsDefault['type'] == null) optionsDefault['type'] = 'spl';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







