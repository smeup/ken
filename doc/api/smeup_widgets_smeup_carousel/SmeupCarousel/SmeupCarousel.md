


# SmeupCarousel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupCarousel([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)>? data, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'CAU', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupCarouselModel.defaultHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? autoPlay = false, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = ''})





## Implementation

```dart
SmeupCarousel(this.scaffoldKey, this.formKey, this.data,
    {this.id = '',
    this.type = 'CAU',
    this.height = SmeupCarouselModel.defaultHeight,
    this.autoPlay = false,
    this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
}
```







