


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  ProgressIndicatorThemeData progressIndicatorThemeData =
      SmeupConfigurationService.getTheme().progressIndicatorTheme;
  defaultColor = progressIndicatorThemeData.color;
  defaultLinearTrackColor = progressIndicatorThemeData.linearTrackColor;

  // ----------------- set properties from default

  if (obj.color == null) obj.color = SmeupProgressBarModel.defaultColor;
  if (obj.linearTrackColor == null)
    obj.linearTrackColor = SmeupProgressBarModel.defaultLinearTrackColor;
}
```







