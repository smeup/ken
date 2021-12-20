


# invoke method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(smeupFun) async {
  switch (smeupFun.fun['fun']['component']) {
    case 'EXD':
      try {
        Map<String, dynamic> data;

        if (jsons != null &&
            jsons.keys.contains(smeupFun.fun['fun']['obj2']['k'])) {
          data = jsons[smeupFun.fun['fun']['obj2']['k']];
        } else {
          String jsonFilePath =
              '${SmeupConfigurationService.jsonsPath}/forms/${smeupFun.fun['fun']['obj2']['k']}.json';

          SmeupLogService.writeDebugMessage(
              '*** http request \'SmeupJsonDataService\': $jsonFilePath');

          String jsonString = await rootBundle.loadString(jsonFilePath);

          jsonString =
              SmeupUtilities.replaceDictionaryPlaceHolders(jsonString);

          data = jsonDecode(jsonString);
        }

        var response = Response(
            data: data,
            statusCode: HttpStatus.accepted,
            requestOptions: null);

        SmeupDataService.writeResponseResult(
            response, 'SmeupJsonDataService');

        return SmeupServiceResponse(
            true,
            Response(
                data: data,
                statusCode: HttpStatus.accepted,
                requestOptions: null));
      } catch (e) {
        return SmeupServiceResponse(
            false,
            Response(
                data: 'Error in SmeupJsonDataService',
                statusCode: HttpStatus.badRequest,
                requestOptions: null));
      }

      break;

    default:
      return SmeupServiceResponse(
          false,
          Response(
              data:
                  'Error in SmeupJsonDataService: component ${smeupFun.fun['fun']['component']} not implemented',
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
  }
}
```







