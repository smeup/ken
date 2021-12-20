


# setDefaults method








dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  ProgressIndicatorThemeData progressIndicatorThemeData =
      SmeupConfigurationService.getTheme().progressIndicatorTheme;
  defaultColor = progressIndicatorThemeData.color;
  defaultCircularTrackColor = progressIndicatorThemeData.circularTrackColor;

  // ----------------- set properties from default

  if (obj.color == null) obj.color = SmeupProgressIndicatorModel.defaultColor;
  if (obj.circularTrackColor == null)
    obj.circularTrackColor =
        SmeupProgressIndicatorModel.defaultCircularTrackColor;
}
```







