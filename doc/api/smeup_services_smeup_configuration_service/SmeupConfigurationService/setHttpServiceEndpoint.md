


# setHttpServiceEndpoint method








dynamic setHttpServiceEndpoint
()








## Implementation

```dart
static setHttpServiceEndpoint() {
  final savedHttpServiceEndpoint =
      _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.HTTP);

  if (savedHttpServiceEndpoint != null && savedHttpServiceEndpoint.isNotEmpty)
    _httpServiceEndpoint = savedHttpServiceEndpoint;
  else
    _httpServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
            ?.httpServiceEndpoint ??
        '';
}
```







