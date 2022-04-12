


# setDefaults method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaults
(dynamic obj)








## Implementation

```dart
static setDefaults(dynamic obj) {
  defaultSplashColor = SmeupConfigurationService.getTheme()!.splashColor;
  defaultLoaderColor = SmeupConfigurationService.getTheme()!.splashColor;
  defaultcircularTrackColor = SmeupConfigurationService.getTheme()!
      .progressIndicatorTheme
      .circularTrackColor;

  // ----------------- set properties from default

  if (obj.splashColor == null)
    obj.splashColor = SmeupWaitModel.defaultSplashColor;
  if (obj.loaderColor == null)
    obj.loaderColor = SmeupWaitModel.defaultSplashColor;
  if (obj.circularTrackColor == null)
    obj.circularTrackColor = SmeupWaitModel.defaultcircularTrackColor;
}
```







