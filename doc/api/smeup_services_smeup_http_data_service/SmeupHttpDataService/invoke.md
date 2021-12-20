


# invoke method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun, {[String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceMethod, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceUrl, dynamic httpServiceBody, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) httpServiceContentType, dynamic headers})

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(SmeupFun smeupFun,
    {String httpServiceMethod,
    String httpServiceUrl,
    dynamic httpServiceBody,
    String httpServiceContentType,
    dynamic headers}) async {
  try {
    dynamic data;
    Response response;

    SmeupLogService.writeDebugMessage(
        '*** http request \'SmeupHttpDataService\': ${jsonEncode(data)}');

    response = await invokeDio(
        url: httpServiceUrl,
        body: httpServiceBody,
        method: httpServiceMethod,
        contentType: httpServiceContentType,
        headers: headers);

    SmeupDataService.writeResponseResult(response, 'SmeupHttpDataService');

    bool isValid = SmeupDataService.isValid(response.statusCode);

    return SmeupServiceResponse(
        isValid,
        Response(
            data: response,
            statusCode: response.statusCode,
            requestOptions: null));
  } catch (e) {
    return SmeupServiceResponse(
        false,
        Response(
            data: 'Error in SmeupHttpDataService',
            statusCode: HttpStatus.badRequest,
            requestOptions: null));
  }
}
```







