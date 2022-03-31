


# getServiceImplementation method








[SmeupDataServiceInterface](../../smeup_services_smeup_data_service_interface/SmeupDataServiceInterface-class.md) getServiceImplementation
([String](https://api.flutter.dev/flutter/dart-core/String-class.html) name)








## Implementation

```dart
static SmeupDataServiceInterface getServiceImplementation(String name) {
  if (services[name] == null) {
    SmeupLogService.writeDebugMessage(
        ' The server implementation \'$name\' does not exist, will be used SmeupDefaultDataService',
        logType: LogType.warning);
    return services['*DEFAULT'];
  } else {
    return services[name];
  }
}
```







