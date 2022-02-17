


# init method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;void> init
([BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html) context, {[LogType](../../smeup_services_smeup_log_service/LogType.md) logLevel = LogType.none, dynamic localizationService, [Map](https://api.flutter.dev/flutter/dart-core/Map-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html), [SmeupDataServiceInterface](../../smeup_services_smeup_data_service_interface/SmeupDataServiceInterface-class.md)> customDataServices, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) enableCache = false, [AuthenticationModel](../../smeup_models_authentication_model/AuthenticationModel-class.md) authenticationModel, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) appBarImage = '', [SmeupDataTransformerInterface](../../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md) defaultServiceDataTransformer, [SmeupDataTransformerInterface](../../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md) httpServiceDataTransformer, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) defaultAutoAdaptHeight = true})








## Implementation

```dart
static Future<void> init(BuildContext context,
    {LogType logLevel = LogType.none,
    dynamic localizationService,
    Map<String, SmeupDataServiceInterface> customDataServices,
    bool enableCache = false,
    AuthenticationModel authenticationModel,
    String appBarImage = '',
    SmeupDataTransformerInterface defaultServiceDataTransformer,
    SmeupDataTransformerInterface httpServiceDataTransformer,
    bool defaultAutoAdaptHeight = true}) async {
  await SmeupConfigurationService.setAppConfiguration();

  SmeupConfigurationService.defaultAutoAdaptHeight = defaultAutoAdaptHeight;
  SmeupConfigurationService.logLevel = logLevel;
  SmeupConfigurationService.appBarImage = appBarImage;

  await SmeupConfigurationService.setLocalStorage();

  await SmeupConfigurationService.setTheme(
      SmeupConfigurationService.getAppConfiguration()?.theme);

  SmeupConfigurationService.appDictionary = localizationService;

  SmeupConfigurationService.setDefaultServiceEndpoint();
  SmeupConfigurationService.setHttpServiceEndpoint();

  if (customDataServices != null) {
    customDataServices.entries.forEach((customService) {
      SmeupDataService.services[customService.key] = customService.value;
    });
  }

  if (SmeupConfigurationService.isLogEnabled)
    await SmeupLogService.setLogFile();

  SmeupConfigurationService.authenticationModel =
      authenticationModel ?? AuthenticationModel();

  SmeupConfigurationService.setPackageInfo(packageInfoModel);
  if (context != null) SmeupConfigurationService.setHolidays(context);
  if (enableCache) SmeupCacheService.init();

  SmeupConfigurationService.defaultServiceDataTransformer =
      defaultServiceDataTransformer ?? NullTransformer();

  SmeupConfigurationService.httpServiceDataTransformer =
      httpServiceDataTransformer ?? NullTransformer();

  SmeupConfigurationService.jsonsPath = 'assets/jsons';
  SmeupConfigurationService.imagesPath = 'assets/images';
  SmeupDataService.initInternalService();
}
```







