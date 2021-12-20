


# load method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupLocalizationService](../../smeup_services_SmeupLocalizationService/SmeupLocalizationService-class.md)> load
([Locale](https://api.flutter.dev/flutter/dart-ui/Locale-class.html) locale)

_override_



<p>Start loading the resources for <code>locale</code>. The returned future completes
when the resources have finished loading.</p>
<p>It's assumed that the this method will return an object that contains
a collection of related resources (typically defined with one method per
resource). The object will be retrieved with <a href="https://api.flutter.dev/flutter/widgets/Localizations/of.html">Localizations.of</a>.</p>



## Implementation

```dart
@override
Future<SmeupLocalizationService> load(Locale locale) {
  // Returning a SynchronousFuture here because an async "load" operation
  // isn't needed to produce an instance of DemoLocalizations.
  return SynchronousFuture<SmeupLocalizationService>(
      SmeupLocalizationService(locale));
}
```







