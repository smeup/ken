


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  var textStyle = SmeupConfigurationService.getTheme()!.textTheme.headline1!;
  defaultFontBold = textStyle.fontWeight == FontWeight.bold;
  defaultFontSize = textStyle.fontSize;
  defaultFontColor = textStyle.color;

  var captionStyle = SmeupConfigurationService.getTheme()!.textTheme.caption!;
  defaultCaptionFontBold = captionStyle.fontWeight == FontWeight.bold;
  defaultCaptionFontSize = captionStyle.fontSize;
  defaultCaptionFontColor = captionStyle.color;

  var iconTheme = SmeupConfigurationService.getTheme()!.iconTheme;
  defaultIconSize = iconTheme.size;
  defaultIconColor = iconTheme.color;

  // ----------------- set properties from default

  if (obj.fontBold == null)
    obj.fontBold = SmeupDashboardModel.defaultFontBold;
  if (obj.fontColor == null)
    obj.fontColor = SmeupDashboardModel.defaultFontColor;
  if (obj.fontSize == null)
    obj.fontSize = SmeupDashboardModel.defaultFontSize;

  if (obj.captionFontBold == null)
    obj.captionFontBold = SmeupDashboardModel.defaultCaptionFontBold;
  if (obj.captionFontColor == null)
    obj.captionFontColor = SmeupDashboardModel.defaultCaptionFontColor;
  if (obj.captionFontSize == null)
    obj.captionFontSize = SmeupDashboardModel.defaultCaptionFontSize;

  if (obj.iconSize == null)
    obj.iconSize = SmeupDashboardModel.defaultIconSize;
  if (obj.iconColor == null)
    obj.iconColor = SmeupDashboardModel.defaultIconColor;
}
```







