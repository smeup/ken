


# SmeupTree constructor







SmeupTree([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) type = 'TRE', [String](https://api.flutter.dev/flutter/dart-core/String-class.html) title = '', [List](https://api.flutter.dev/flutter/dart-core/List-class.html) data, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html) onClientClick, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = SmeupTreeModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = SmeupTreeModel.defaultHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelFontSize = SmeupTreeModel.defaultLabelFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) labelBackColor = SmeupTreeModel.defaultLabelBackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) labelFontColor = SmeupTreeModel.defaultLabelFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) labelFontbold = SmeupTreeModel.defaultLabelFontbold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelVerticalSpacing = SmeupTreeModel.defaultLabelVerticalSpacing, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) labelHeight = SmeupTreeModel.defaultLabelHeight, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentFontSize = SmeupTreeModel.defaultParentFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) parentBackColor = SmeupTreeModel.defaultParentBackColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) parentFontColor = SmeupTreeModel.defaultParentFontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) parentFontbold = SmeupTreeModel.defaultParentFontbold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentVerticalSpacing = SmeupTreeModel.defaultParentVerticalSpacing, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) parentHeight = SmeupTreeModel.defaultParentHeight})





## Implementation

```dart
SmeupTree(
  this.scaffoldKey,
  this.formKey, {
  this.id = '',
  this.type = 'TRE',
  this.title = '',
  this.data,
  this.onClientClick,
  this.width = SmeupTreeModel.defaultWidth,
  this.height = SmeupTreeModel.defaultHeight,
  this.labelFontSize = SmeupTreeModel.defaultLabelFontSize,
  this.labelBackColor = SmeupTreeModel.defaultLabelBackColor,
  this.labelFontColor = SmeupTreeModel.defaultLabelFontColor,
  this.labelFontbold = SmeupTreeModel.defaultLabelFontbold,
  this.labelVerticalSpacing = SmeupTreeModel.defaultLabelVerticalSpacing,
  this.labelHeight = SmeupTreeModel.defaultLabelHeight,
  this.parentFontSize = SmeupTreeModel.defaultParentFontSize,
  this.parentBackColor = SmeupTreeModel.defaultParentBackColor,
  this.parentFontColor = SmeupTreeModel.defaultParentFontColor,
  this.parentFontbold = SmeupTreeModel.defaultParentFontbold,
  this.parentVerticalSpacing = SmeupTreeModel.defaultParentVerticalSpacing,
  this.parentHeight = SmeupTreeModel.defaultParentHeight,
}) : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  if (data == null) {
    data = List<dynamic>.empty(growable: true);
  }
}
```







