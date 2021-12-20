


# SmeupCarouselModel constructor







SmeupCarouselModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoPlay = false, dynamic title = ''})





## Implementation

```dart
SmeupCarouselModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    this.height = defaultHeight,
    this.autoPlay = false,
    title = ''})
    : super(formKey, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







