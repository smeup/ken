


# isSupported method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) isSupported
([Locale](https://api.flutter.dev/flutter/dart-ui/Locale-class.html) locale)

_override_



<p>Whether resources for the given locale can be loaded by this delegate.</p>
<p>Return true if the instance of <code>T</code> loaded by this delegate's <a href="../../smeup_services_smeupLocalizationDelegate/SmeupLocalizationDelegate/load.md">load</a>
method supports the given <code>locale</code>'s language.</p>



## Implementation

```dart
@override
bool isSupported(Locale locale) =>
    ['en', 'it', 'fr'].contains(locale.languageCode);
```







