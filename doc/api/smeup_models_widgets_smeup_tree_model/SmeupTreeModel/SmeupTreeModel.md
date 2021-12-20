


# SmeupTreeModel constructor







SmeupTreeModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, dynamic title = '', [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelFontSize = defaultLabelFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) labelBackColor = defaultLabelBackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) labelFontColor = defaultLabelFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) labelFontbold = defaultLabelFontbold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelVerticalSpacing = defaultLabelVerticalSpacing, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelHeight = defaultLabelHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentFontSize = defaultParentFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) parentBackColor = defaultParentBackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) parentFontColor = defaultParentFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) parentFontbold = defaultParentFontbold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentVerticalSpacing = defaultParentVerticalSpacing, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentHeight = defaultParentHeight})





## Implementation

```dart
SmeupTreeModel({
  id,
  type,
  GlobalKey<FormState> formKey,
  title = '',
  this.width = defaultWidth,
  this.height = defaultHeight,
  this.labelFontSize = defaultLabelFontSize,
  this.labelBackColor = defaultLabelBackColor,
  this.labelFontColor = defaultLabelFontColor,
  this.labelFontbold = defaultLabelFontbold,
  this.labelVerticalSpacing = defaultLabelVerticalSpacing,
  this.labelHeight = defaultLabelHeight,
  this.parentFontSize = defaultParentFontSize,
  this.parentBackColor = defaultParentBackColor,
  this.parentFontColor = defaultParentFontColor,
  this.parentFontbold = defaultParentFontbold,
  this.parentVerticalSpacing = defaultParentVerticalSpacing,
  this.parentHeight = defaultParentHeight,
}) : super(formKey, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
}
```







