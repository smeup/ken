


# SmeupProgressIndicatorModel constructor







SmeupProgressIndicatorModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) color, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) circularTrackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) size = defaultSize, dynamic title = ''})





## Implementation

```dart
SmeupProgressIndicatorModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    this.color,
    this.circularTrackColor,
    this.size = defaultSize,
    title = ''})
    : super(formKey, title: title, id: id, type: type) {
  if (optionsDefault['type'] == null) optionsDefault['type'] = 'pgi';
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







