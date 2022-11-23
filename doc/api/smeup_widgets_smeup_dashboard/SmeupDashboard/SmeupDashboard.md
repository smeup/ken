


# SmeupDashboard constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupDashboard([GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[ScaffoldState](https://api.flutter.dev/flutter/material/ScaffoldState-class.html)> scaffoldKey, [GlobalKey](https://api.flutter.dev/flutter/widgets/GlobalKey-class.html)&lt;[FormState](https://api.flutter.dev/flutter/widgets/FormState-class.html)>? formKey, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? data, {dynamic id = '', dynamic type = 'DSH', [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? fontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? fontSize, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? fontBold, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)? captionFontBold, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? captionFontSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? captionFontColor, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? iconSize, [Color](https://api.flutter.dev/flutter/dart-ui/Color-class.html)? iconColor, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceIcon, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceText, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceUm, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? forceValue, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? valueColName = SmeupDashboardModel.defaultValueColName, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? text = '', [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? unitOfMeasure = '', [int](https://api.flutter.dev/flutter/dart-core/int-class.html)? icon, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? selectLayout = SmeupDashboardModel.defaultSelectLayout, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? width = SmeupDashboardModel.defaultWidth, [double](https://api.flutter.dev/flutter/dart-core/double-class.html)? height = SmeupDashboardModel.defaultHeight, [EdgeInsetsGeometry](https://api.flutter.dev/flutter/painting/EdgeInsetsGeometry-class.html)? padding = SmeupDashboardModel.defaultPadding, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? numberFormat = SmeupDashboardModel.defaultNumberFormat, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? title = ''})





## Implementation

```dart
SmeupDashboard(this.scaffoldKey, this.formKey, this.data,
    {id = '',
    type = 'DSH',
    this.fontColor,
    this.fontSize,
    this.fontBold,
    this.captionFontBold,
    this.captionFontSize,
    this.captionFontColor,
    this.iconSize,
    this.iconColor,
    this.forceIcon,
    this.forceText,
    this.forceUm,
    this.forceValue,
    this.valueColName = SmeupDashboardModel.defaultValueColName,
    this.text = '',
    this.unitOfMeasure = '',
    this.icon,
    this.selectLayout = SmeupDashboardModel.defaultSelectLayout,
    this.width = SmeupDashboardModel.defaultWidth,
    this.height = SmeupDashboardModel.defaultHeight,
    this.padding = SmeupDashboardModel.defaultPadding,
    this.numberFormat = SmeupDashboardModel.defaultNumberFormat,
    this.title = ''})
    : super(key: Key(SmeupUtilities.getWidgetId(type, id))) {
  id = SmeupUtilities.getWidgetId(type, id);
  SmeupDashboardModel.setDefaults(this);
}
```







