


# resetAltServiceEndpoint method




    *[<Null safety>](https://dart.dev/null-safety)*




void resetAltServiceEndpoint
()








## Implementation

```dart
static void resetAltServiceEndpoint() {
  SmeupConfigurationService.getLocalStorage()!
      .remove('$ALT_SERVICE_ENDPOINTS.DEFAULT'.split('.').last);
  SmeupConfigurationService.getLocalStorage()!
      .remove('$ALT_SERVICE_ENDPOINTS.HTTP'.split('.').last);
}
```







