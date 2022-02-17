


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
    case 'FBK':
      try {
        Map<String, dynamic> data = SmeupDataService.getEmptyDataStructure();
        String message = '';

        if (smeupFun.fun['fun']['P'] != null) {
          message = smeupFun.fun['fun']['P'];
        }

        LogType logType = LogType.info;
        String gravity = smeupFun.fun['fun']['obj1']['k'];
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
        if (smeupFun.fun['fun']['obj2']['k'] != null) {
          milliseconds =
              int.tryParse(smeupFun.fun['fun']['obj2']['k']) ?? 500;
        }

        data['messages'] = [
          {
            "gravity": logType,
            "message": message,
            "milliseconds": milliseconds
          }
        ];

        var response = Response(
            data: data,
            statusCode: HttpStatus.accepted,
            requestOptions: null);

        SmeupDataService.writeResponseResult(
            response, 'SmeupMessageDataService');

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
                data: 'Error in SmeupMessageDataService',
                statusCode: HttpStatus.badRequest,
                requestOptions: null));
      }

      break;

    default:
      return SmeupServiceResponse(
          false,
          Response(
              data:
                  'Error in SmeupMessageDataService: component ${smeupFun.fun['fun']['component']} not implemented',
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
  }
}
```







