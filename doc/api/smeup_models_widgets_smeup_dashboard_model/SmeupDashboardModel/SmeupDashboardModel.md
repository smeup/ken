


# SmeupDashboardModel constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupDashboardModel({dynamic id, dynamic type, dynamic formKey, dynamic scaffoldKey, dynamic context, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueColName = defaultValueColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? umColName = defaultUmColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? textColName = defaultTextColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? iconColName = defaultIconColName, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? selectLayout = defaultSelectLayout, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = defaultHeight, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceText = defaultForceText, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceValue = defaultForceValue, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceUm = defaultForceUm, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceIcon = defaultForceIcon, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? numberFormat = defaultNumberFormat, dynamic title = ''})





## Implementation

```dart
SmeupDashboardModel(
    {id,
    type,
    formKey,
    scaffoldKey,
    context,
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.iconSize,
    this.iconColor,
    this.valueColName = defaultValueColName,
    this.umColName = defaultUmColName,
    this.textColName = defaultTextColName,
    this.iconColName = defaultIconColName,
    this.padding = defaultPadding,
    this.selectLayout = defaultSelectLayout,
    this.width = defaultWidth,
    this.height = defaultHeight,
    this.forceText = defaultForceText,
    this.forceValue = defaultForceValue,
    this.forceUm = defaultForceUm,
    this.forceIcon = defaultForceIcon,
    this.numberFormat = defaultNumberFormat,
    title = ''})
    : super(formKey, scaffoldKey, context, title: title, id: id, type: type) {
  if (iconColor == null)
    iconColor = SmeupConfigurationService.getTheme()!.iconTheme.color;
  id = SmeupUtilities.getWidgetId('DSH', id);
  SmeupDataService.incrementDataFetch(id);
  setDefaults(this);
}
```







