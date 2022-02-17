


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

    return SmeupServiceResponse(
        isValid,
        Response(
            data: response.data,
            statusCode: response.statusCode,
            requestOptions: null));
  } catch (e) {
    return SmeupServiceResponse(
        false,
        Response(
            data: 'Error in SmeupDefaultDataService',
            statusCode: HttpStatus.badRequest,
            requestOptions: null));
  }
}
```







