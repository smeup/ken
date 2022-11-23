


# invoke method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([Fun](../../smeup_models_fun/Fun-class.md)? smeupFun, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html)? httpServiceMethod, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? httpServiceUrl, dynamic httpServiceBody, [String](https://api.flutter.dev/flutter/dart-core/String-class.html)? httpServiceContentType, dynamic headers})








## Implementation

```dart
static Future<SmeupServiceResponse> invoke(Fun? smeupFun,
    {String? httpServiceMethod,
    String? httpServiceUrl,
    dynamic httpServiceBody,
    String? httpServiceContentType,
    dynamic headers}) async {
  SmeupDataServiceInterface? smeupDataService =
      SmeupDataService.getServiceImplementation(
          smeupFun == null ? null : smeupFun.identifier.service);

  if (smeupFun != null) {
    smeupFun.replaceVariables();
  }

  // Read response from service

  SmeupServiceResponse response;

  if (smeupDataService is SmeupDefaultDataService)
    response = await smeupDataService.invoke(smeupFun!);
  else if (smeupDataService is SmeupHttpDataService)
    response = await smeupDataService.invoke(smeupFun,
        httpServiceMethod: httpServiceMethod,
        httpServiceUrl: httpServiceUrl,
        httpServiceBody: httpServiceBody,
        httpServiceContentType: httpServiceContentType,
        headers: headers);
  else
    response = await smeupDataService!.invoke(smeupFun!);

  return response;
}
```







