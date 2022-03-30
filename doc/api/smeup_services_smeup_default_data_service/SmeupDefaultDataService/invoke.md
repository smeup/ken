


# invoke method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(SmeupFun smeupFun) async {
  try {
    dynamic data;
    Response response;
    String url;
    String contentType;

    url = '${SmeupConfigurationService.getDefaultServiceEndpoint()}/jfun';
    contentType = 'application/json';
    data = smeupFun.fun;

    SmeupLogService.writeDebugMessage(
        '*** http request \'SmeupDefaultDataService\': ${jsonEncode(data)}');

    response = await invokeDio(
        url: url,
        body: data,
        method: 'post',
        contentType: contentType,
        cache: 0,
        forceCache: false);

    SmeupDataService.writeResponseResult(response, 'SmeupDefaultDataService');

    bool isValid = SmeupDataService.isValid(response.statusCode);

    dynamic responseData;

// Apply transformation to service response (only on success)
    if (isValid && getTransformer() is NullTransformer == false) {
      responseData = getTransformer().transform(smeupFun, response.data);
    } else {
      final message =
          'SmeupDefaultDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
      responseData = _getErrorResponse(message);
    }

    return SmeupServiceResponse(
        isValid,
        Response(
            data: responseData,
            statusCode: response.statusCode,
            requestOptions: null));
  } catch (e) {
    final message =
        'SmeupDefaultDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







