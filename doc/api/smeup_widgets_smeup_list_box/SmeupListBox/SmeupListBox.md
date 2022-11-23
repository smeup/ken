


# SmeupListBox constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupListBox([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, dynamic data, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? id = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? type = 'BOX', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? borderRadius, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? backColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? layout = SmeupListBoxModel.defaultLayout, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupListBoxModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupListBoxModel.defaultHeight, [Axis](https://api.flutter.dev/flutter/painting/Axis.html)? orientation = SmeupListBoxModel.defaultOrientation, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupListBoxModel.defaultPadding, [SmeupListType](../../smeup_models_widgets_smeup_list_box_model/SmeupListType.md)? listType = SmeupListBoxModel.defaultListType, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? portraitColumns = SmeupListBoxModel.defaultPortraitColumns, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? landscapeColumns = SmeupListBoxModel.defaultLandscapeColumns, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? backgroundColName = SmeupListBoxModel.defaultBackgroundColName, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? listHeight = SmeupListBoxModel.defaultListHeight, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? showSelection = false, [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? selectedRow = -1, dynamic title = '', dynamic showLoader = false, [Function](https://api.flutter.dev/flutter/dart-core/Function-class.html)? clientOnItemTap, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) dismissEnabled = false, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? defaultSort = SmeupListBoxModel.defaultDefaultSort})





## Implementation

```dart
SmeupListBox(this.scaffoldKey, this.formKey, this.data,
    {this.id = '',
    this.type = 'BOX',
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.backColor,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.layout = SmeupListBoxModel.defaultLayout,
    this.width = SmeupListBoxModel.defaultWidth,
    this.height = SmeupListBoxModel.defaultHeight,
    this.orientation = SmeupListBoxModel.defaultOrientation,
    this.padding = SmeupListBoxModel.defaultPadding,
    this.listType = SmeupListBoxModel.defaultListType,
    this.portraitColumns = SmeupListBoxModel.defaultPortraitColumns,
    this.landscapeColumns = SmeupListBoxModel.defaultLandscapeColumns,
    this.backgroundColName = SmeupListBoxModel.defaultBackgroundColName,
    this.listHeight = SmeupListBoxModel.defaultListHeight,
    this.showSelection = false,
    this.selectedRow = -1,
    title = '',
    showLoader: false,
    this.clientOnItemTap,
    this.dismissEnabled = false,
    this.defaultSort = SmeupListBoxModel.defaultDefaultSort})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupListBoxModel.setDefaults(this);
}
```







