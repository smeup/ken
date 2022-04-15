


# saveAltServiceEndpoint method




    *[<Null safety>](https://dart.dev/null-safety)*




void saveAltServiceEndpoint
([ALT_SERVICE_ENDPOINTS](../../smeup_services_smeup_configuration_service/ALT_SERVICE_ENDPOINTS.md) serviceEndpointType, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) value)








## Implementation

```dart
static void saveAltServiceEndpoint(
    ALT_SERVICE_ENDPOINTS serviceEndpointType, String value) {
  SmeupConfigurationService.getLocalStorage()!
      .setString('$serviceEndpointType'.split('.').last, value);
}
```







