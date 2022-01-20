


# setDefaultServiceEndpoint method








dynamic setDefaultServiceEndpoint
()








## Implementation

```dart
static setDefaultServiceEndpoint() {
  // Load service endpoints from shared preferences
  final savedDefaultServiceEndpoint =
      _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.DEFAULT);

  if (savedDefaultServiceEndpoint.isNotEmpty)
    _defaultServiceEndpoint = savedDefaultServiceEndpoint;
  else
    _defaultServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
        .defaultServiceEndpoint;
}
```






