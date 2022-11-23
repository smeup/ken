


# invoke method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(smeupFun) async {
  switch (smeupFun.identifier.component) {
    case 'EXD':
      try {
        Map<String, dynamic>? data;

        String? fileName = smeupFun.getObjectByName('obj2').k;

        List<Map<String, dynamic>> list = smeupFun.server;

        final sourceMap =
            list.firstWhereOrNull((element) => element['key'] == 'source');
        String? source = sourceMap != null ? sourceMap['value'] : '';

        String jsonString = '';

        if (source == 'firestore') {
          jsonString = await getFromFirestore(smeupFun, fileName);
        } else if (source!.isNotEmpty) {
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
            requestOptions: RequestOptions(path: ''));

        SmeupDataService.writeResponseResult(
            response, 'SmeupJsonDataService');

        return SmeupServiceResponse(
            true,
            Response(
                data: data,
                statusCode: HttpStatus.accepted,
                requestOptions: RequestOptions(path: '')));
      } catch (e) {
        SmeupLogService.writeDebugMessage('Error in JsonDataService: $e',
            logType: LogType.error);

        return SmeupServiceResponse(
            false,
            Response(
                data: 'Error in SmeupJsonDataService: ${e.toString()}',
                statusCode: HttpStatus.badRequest,
                requestOptions: RequestOptions(path: '')));
      }

    default:
      return SmeupServiceResponse(
          false,
          Response(
              data:
                  'Error in SmeupJsonDataService: component ${smeupFun.identifier.component} not implemented',
              statusCode: HttpStatus.badRequest,
              requestOptions: RequestOptions(path: '')));
  }
}
```







