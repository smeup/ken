


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
    case 'FBK':
      try {
        Map<String, dynamic> data = SmeupDataService.getEmptyDataStructure();

        List<Map<String, dynamic>> list = smeupFun.parameters;

        final message =
            list.firstWhereOrNull((element) => element['key'] == 'message');

        LogType logType = LogType.info;
        String gravity = smeupFun.getObjectByName('obj1').k;
        if (gravity.isNotEmpty) {
          switch (gravity) {
            case "info":
              logType = LogType.info;
              break;
            case "debug":
              logType = LogType.debug;
              break;
            case "error":
              logType = LogType.error;
              break;
            case "none":
              logType = LogType.none;
              break;
            case "warning":
              logType = LogType.warning;
              break;
            default:
              logType = LogType.info;
          }
        }

        int milliseconds = 500;
        if (smeupFun.getObjectByName('obj2').k.isNotEmpty) {
          milliseconds =
              int.tryParse(smeupFun.getObjectByName('obj2').k) ?? 500;
        }

        data['messages'] = [
          {
            "gravity": logType,
            "message": message!['value'],
            "milliseconds": milliseconds
          }
        ];

        var response = Response(
            data: data,
            statusCode: HttpStatus.accepted,
            requestOptions: RequestOptions(path: ''));

        SmeupDataService.writeResponseResult(
            response, 'SmeupMessageDataService');

        return SmeupServiceResponse(
            true,
            Response(
                data: data,
                statusCode: HttpStatus.accepted,
                requestOptions: RequestOptions(path: '')));
      } catch (e) {
        return SmeupServiceResponse(
            false,
            Response(
                data: 'Error in SmeupMessageDataService',
                statusCode: HttpStatus.badRequest,
                requestOptions: RequestOptions(path: '')));
      }

    default:
      return SmeupServiceResponse(
          false,
          Response(
              data:
                  'Error in SmeupMessageDataService: component ${smeupFun.identifier.component} not implemented',
              statusCode: HttpStatus.badRequest,
              requestOptions: RequestOptions(path: '')));
  }
}
```







