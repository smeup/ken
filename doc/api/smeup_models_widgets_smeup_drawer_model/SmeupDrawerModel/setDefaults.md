


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  AppBarTheme appBarTheme = SmeupConfigurationService.getTheme()!.appBarTheme;

  TextStyle titleStyle = appBarTheme.titleTextStyle!;
  defaultTitleFontSize = titleStyle.fontSize;
  defaultTitleFontColor = titleStyle.color;
  defaultTitleFontBold = titleStyle.fontWeight == FontWeight.bold;

  TextStyle elementStyle = appBarTheme.toolbarTextStyle!;
  defaultElementFontSize = elementStyle.fontSize;
  defaultElementFontColor = elementStyle.color;
  defaultElementFontBold = elementStyle.fontWeight == FontWeight.bold;

  defaultAppBarBackColor = appBarTheme.backgroundColor;

  // ----------------- set properties from default

  if (obj.titleFontSize == null)
    obj.titleFontSize = SmeupDrawerModel.defaultTitleFontSize;
  if (obj.titleFontColor == null)
    obj.titleFontColor = SmeupDrawerModel.defaultTitleFontColor;
  if (obj.titleFontBold == null)
    obj.titleFontBold = SmeupDrawerModel.defaultTitleFontBold;

  if (obj.elementFontSize == null)
    obj.elementFontSize = SmeupDrawerModel.defaultElementFontSize;
  if (obj.elementFontColor == null)
    obj.elementFontColor = SmeupDrawerModel.defaultElementFontColor;
  if (obj.elementFontBold == null)
    obj.elementFontBold = SmeupDrawerModel.defaultElementFontBold;

  if (obj.appBarBackColor == null)
    obj.appBarBackColor = SmeupDrawerModel.defaultAppBarBackColor;
}
```







