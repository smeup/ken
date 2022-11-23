


# invoke method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun, {[BuildContext](https://api.flutter.dev/flutter/widgets/BuildContext-class.html)? context})

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(smeupFun, {BuildContext? context}) async {
  try {
    SmeupLogService.writeDebugMessage(
        '*** \'SmeupImageDataService\': ${smeupFun.getObjectByName('obj1').k}');

    final imageLocalPath =
        '${SmeupConfigurationService.imagesPath}/${smeupFun.getObjectByName('obj1').k}';

    return SmeupServiceResponse(true, {"imageLocalPath": imageLocalPath});
  } catch (e) {
    return SmeupServiceResponse(
        false,
        Response(
            data: 'Error in SmeupImageDataService',
            statusCode: HttpStatus.badRequest,
            requestOptions: RequestOptions(path: '')));
  }
}
```







