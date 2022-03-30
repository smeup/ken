


# invoke method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceMethod, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceUrl, dynamic httpServiceBody, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceContentType, dynamic headers})








## Implementation

```dart
static Future<SmeupServiceResponse> invoke(SmeupFun smeupFun,
    {String httpServiceMethod,
    String httpServiceUrl,
    dynamic httpServiceBody,
    String httpServiceContentType,
    dynamic headers}) async {
  SmeupDataServiceInterface smeupDataService =
      SmeupDataService.getServiceImplementation(
          smeupFun == null ? null : smeupFun.fun['fun']['service']);

  var newSmeupFun;
  if (smeupFun != null && smeupFun.fun != null) {
    String funString = jsonEncode(smeupFun.fun);
    funString =
        SmeupDynamismService.replaceFunVariables(funString, smeupFun.formKey);
    final fun = jsonDecode(funString);
    newSmeupFun = SmeupFun(
        fun, smeupFun.formKey, smeupFun.scaffoldKey, smeupFun.context);
  }

  // Read response from service

  SmeupServiceResponse response;

  if (smeupDataService is SmeupDefaultDataService)
    response = await smeupDataService.invoke(newSmeupFun);
  else if (smeupDataService is SmeupHttpDataService)
    response = await smeupDataService.invoke(newSmeupFun,
        httpServiceMethod: httpServiceMethod,
        httpServiceUrl: httpServiceUrl,
        httpServiceBody: httpServiceBody,
        httpServiceContentType: httpServiceContentType,
        headers: headers);
  else
    response = await smeupDataService.invoke(newSmeupFun);

  return response;
}
```







