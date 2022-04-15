


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  DividerThemeData dividerData =
      SmeupConfigurationService.getTheme()!.dividerTheme;

  defaultColor = dividerData.color;
  defaultThickness = dividerData.thickness;

  // ----------------- set properties from default
  if (obj.color == null) obj.color = defaultColor;
  if (obj.thickness == null) obj.thickness = defaultThickness;
}
```







