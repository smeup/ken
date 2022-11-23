


# setDefaultServiceEndpoint method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic setDefaultServiceEndpoint
()








## Implementation

```dart
static setDefaultServiceEndpoint() {
  // Load service endpoints from shared preferences
  final savedDefaultServiceEndpoint =
      _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.DEFAULT);

  if (savedDefaultServiceEndpoint != null &&
      savedDefaultServiceEndpoint.isNotEmpty)
    _defaultServiceEndpoint = savedDefaultServiceEndpoint;
  else
    _defaultServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
            ?.defaultServiceEndpoint ??
        '';
}
```







