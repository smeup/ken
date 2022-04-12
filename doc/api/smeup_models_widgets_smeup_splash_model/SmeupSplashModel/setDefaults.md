


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  defaultColor = SmeupConfigurationService.getTheme()!.splashColor;

  // ----------------- set properties from default

  if (obj.color == null) obj.color = SmeupSplashModel.defaultColor;
}
```







