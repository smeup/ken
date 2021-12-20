


# SmeupDrawer constructor







SmeupDrawer([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'DRW', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) appBarBackColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) titleFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) titleFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) titleFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) elementFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) elementFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) elementFontBold, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) imageUrl = '', [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[SmeupDrawerDataElement](../../smeup_models_widgets_smeup_drawer_data_element/SmeupDrawerDataElement-class.md)> data, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) imageWidth = SmeupDrawerModel.defaultImageWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) imageHeight = SmeupDrawerModel.defaultImageHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showItemDivider = SmeupDrawerModel.defaultShowItemDivider})





## Implementation

```dart
SmeupDrawer(this.scaffoldKey, this.formKey,
    {this.id = '',
    this.type = 'DRW',
    this.appBarBackColor,
    this.titleFontSize,
    this.titleFontColor,
    this.titleFontBold,
    this.elementFontSize,
    this.elementFontColor,
    this.elementFontBold,
    this.title = '',
    this.imageUrl = '',
    this.data,
    this.imageWidth = SmeupDrawerModel.defaultImageWidth,
    this.imageHeight = SmeupDrawerModel.defaultImageHeight,
    this.showItemDivider = SmeupDrawerModel.defaultShowItemDivider})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupDrawerModel.setDefaults(this);
}
```







