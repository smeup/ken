


# SmeupCarouselModel constructor







SmeupCarouselModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) autoPlay = false, dynamic title = ''})





## Implementation

```dart
SmeupCarouselModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.height = defaultHeight,
    this.autoPlay = false,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







