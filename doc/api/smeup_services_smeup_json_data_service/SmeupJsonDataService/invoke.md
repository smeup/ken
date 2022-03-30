


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

        String fileName = smeupFun.fun['fun']['obj2']['k'];

        //String customFolder = smeupFun.fun['fun']['obj1']['k'];
        List<Map<String, dynamic>> list = smeupFun.getParameters();

        final sourceMap = list.firstWhere(
            (element) => element['key'] == 'source',
            orElse: () => null);
        String source = sourceMap != null ? sourceMap['value'] : '';

        String jsonString = '';

        if (source == 'firestore') {
          jsonString = await getFromFirestore(smeupFun, fileName);
        } else if (source.isNotEmpty) {
          jsonString = await getFromCustomPath(source, fileName);
        } else {
          jsonString = await getFromDefaultFolder(source, fileName);
        }

        // replace placeholders
        jsonString = SmeupUtilities.replaceDictionaryPlaceHolders(jsonString);

        // decode
        data = jsonDecode(jsonString);

        // return the response
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
        SmeupLogService.writeDebugMessage('Error in JsonDataService: $e',
            logType: LogType.error);

        return SmeupServiceResponse(
            false,
            Response(
                data: 'Error in SmeupJsonDataService: ${e.toString()}',
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







