


# SmeupDrawerModel constructor







SmeupDrawerModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) appBarBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) titleFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) titleFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) titleFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elementFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) elementFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) elementFontBold, dynamic title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) imageUrl = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html) imageWidth = defaultImageWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) imageHeight = defaultImageHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showItemDivider = defaultShowItemDivider})





## Implementation

```dart
SmeupDrawerModel({
  id,
  type,
  GlobalKey<FormState> formKey,
  this.appBarBackColor,
  this.titleFontSize,
  this.titleFontColor,
  this.titleFontBold,
  this.elementFontSize,
  this.elementFontColor,
  this.elementFontBold,
  title,
  this.imageUrl = '',
  this.imageWidth = defaultImageWidth,
  this.imageHeight = defaultImageHeight,
  this.showItemDivider = defaultShowItemDivider,
}) : super(formKey, title: title, id: id, type: type) {
  if (appBarBackColor == null)
    appBarBackColor =
        SmeupConfigurationService.getTheme().appBarTheme.backgroundColor;
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







