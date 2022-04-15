


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  SliderThemeData sliderThemeData =
      SmeupConfigurationService.getTheme()!.sliderTheme;
  defaultActiveTrackColor = sliderThemeData.activeTrackColor;
  defaultThumbColor = sliderThemeData.thumbColor;
  defaultInactiveTrackColor = sliderThemeData.inactiveTrackColor;

  // ----------------- set properties from default

  if (obj.activeTrackColor == null)
    obj.activeTrackColor = SmeupSliderModel.defaultActiveTrackColor;
  if (obj.thumbColor == null)
    obj.thumbColor = SmeupSliderModel.defaultThumbColor;
  if (obj.inactiveTrackColor == null)
    obj.inactiveTrackColor = SmeupSliderModel.defaultInactiveTrackColor;
}
```







