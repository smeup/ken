


# SmeupSlider constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupSlider([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, {[Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? activeTrackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? thumbColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? inactiveTrackColor, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupSliderModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'SLD', [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? value = 0, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? sldMax = SmeupSliderModel.defaultSldMax, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? sldMin = SmeupSliderModel.defaultSldMin, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnChange})





## Implementation

```dart
SmeupSlider(this.scaffoldKey, this.formKey,
    {this.activeTrackColor,
    this.thumbColor,
    this.inactiveTrackColor,
    this.padding = SmeupSliderModel.defaultPadding,
    this.title,
    this.id = '',
    this.type = 'SLD',
    this.value = 0,
    this.sldMax = SmeupSliderModel.defaultSldMax,
    this.sldMin = SmeupSliderModel.defaultSldMin,
    this.clientOnChange})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupSliderModel.setDefaults(this);
}
```







