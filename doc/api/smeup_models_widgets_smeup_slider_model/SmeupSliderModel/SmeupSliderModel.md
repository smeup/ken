


# SmeupSliderModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupSliderModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)>? scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? activeTrackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? thumbColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? inactiveTrackColor, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? sldMin = defaultSldMin, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? sldMax = defaultSldMax})





## Implementation

```dart
SmeupSliderModel({
  id,
  type,
  GlobalKey<FormState>? formKey,
  GlobalKey<ScaffoldState>? scaffoldKey,
  BuildContext? context,
  this.activeTrackColor,
  this.thumbColor,
  this.inactiveTrackColor,
  this.padding = defaultPadding,
  this.sldMin = defaultSldMin,
  this.sldMax = defaultSldMax,
}) : super(formKey, scaffoldKey, context, title: '', id: id, type: type) {
  if (optionsDefault!['type'] == null) optionsDefault!['type'] = 'sld';
  id = SmeupUtilities.getWidgetId('FLD', id);
  setDefaults(this);
}
```







