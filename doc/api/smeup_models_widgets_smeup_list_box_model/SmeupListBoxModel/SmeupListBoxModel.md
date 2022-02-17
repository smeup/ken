


# SmeupListBoxModel constructor







SmeupListBoxModel({dynamic id, dynamic type, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)> formKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) backColor, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) borderColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) borderRadius, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) fontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) fontColor, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html) captionFontColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) layout = defaultLayout, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) height = defaultHeight, [Axis](https://api.flutter.dev/flutter/painting/Axis.html) orientation = defaultOrientation, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html) padding = defaultPadding, [SmeupListType](../../smeup_models_widgets_smeup_list_box_model/SmeupListType.md) listType = defaultListType, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) portraitColumns = defaultPortraitColumns, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) landscapeColumns = defaultLandscapeColumns, [List](https://api.flutter.dev/flutter/dart-core/List-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> visibleColumns, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) defaultSort = defaultDefaultSort, [double](https://api.flutter.dev/flutter/dart-core/double-class.html) listHeight = defaultListHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) backgroundColName = defaultBackgroundColName, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) showSelection = defaultShowSelection, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) selectedRow = defaultSelectedRow, dynamic title = ''})





## Implementation

```dart
SmeupListBoxModel(
    {id,
    type,
    GlobalKey<FormState> formKey,
    GlobalKey<ScaffoldState> scaffoldKey,
    BuildContext context,
    this.backColor,
    this.borderColor,
    this.borderWidth,
    this.borderRadius,
    this.fontSize,
    this.fontColor,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.layout = defaultLayout,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.orientation = defaultOrientation,
    this.padding = defaultPadding,
    this.listType = defaultListType,
    this.portraitColumns = defaultPortraitColumns,
    this.landscapeColumns = defaultLandscapeColumns,
    this.visibleColumns,
    this.defaultSort = defaultDefaultSort,
    this.listHeight = defaultListHeight,
    this.backgroundColName = defaultBackgroundColName,
    this.showSelection = defaultShowSelection,
    this.selectedRow = defaultSelectedRow,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  SmeupDataService.incrementDataFetch(id);
  if (visibleColumns == null)
    visibleColumns = List<String>.empty(growable: true);
  setDefaults(this);
}
```







