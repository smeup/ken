


# shouldReload method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) shouldReload
(covariant [SmeupLocalizationDelegate](../../smeup_services_smeupLocalizationDelegate/SmeupLocalizationDelegate-class.md) old)

_override_



<p>Returns true if the resources for this delegate should be loaded
again by calling the <a href="../../smeup_services_smeupLocalizationDelegate/SmeupLocalizationDelegate/load.md">load</a> method.</p>
<p>This method is called whenever its <a href="https://api.flutter.dev/flutter/widgets/Localizations-class.html">Localizations</a> widget is
rebuilt. If it returns true then dependent widgets will be rebuilt
after <a href="../../smeup_services_smeupLocalizationDelegate/SmeupLocalizationDelegate/load.md">load</a> has completed.</p>



## Implementation

```dart
@override
bool shouldReload(SmeupLocalizationDelegate old) => false;
```







