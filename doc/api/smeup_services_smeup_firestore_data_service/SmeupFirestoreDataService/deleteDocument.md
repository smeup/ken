


# deleteDocument method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> deleteDocument
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> deleteDocument(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';

    final id = list.firstWhereOrNull((element) => element['key'] == 'id');

    final dataCollection = list
        .firstWhereOrNull((element) => element['key'] == 'dataCollection');

    if (!_isParValid(id)) {
      checkResult = 'The id is empty. FUN: $smeupFun';
    }

    if (!_isParValid(dataCollection)) {
      checkResult = 'The dataCollection is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    bool isOnLine = await SmeupFirestoreShared.isInternetOn();

    if (isOnLine) {
      await fsDatabase
          .collection(dataCollection!['value'])
          .doc(id!['value'])
          .delete();
    } else {
      fsDatabase
          .collection(dataCollection!['value'])
          .doc(id!['value'])
          .delete();
    }

    SmeupVariablesService.setVariable('id', '', formKey: smeupFun.formKey);

    final messages = {
      "messages": [
        {
          "gravity": isOnLine ? LogType.info : LogType.warning,
          "message":
              "${SmeupConfigurationService.appDictionary.getLocalString('updateCompletedSuccessfully')} ${isOnLine ? '' : 'offline'}",
          "smeupObject": {"tipo": "", "parametro": "", "codice": ""}
        }
      ]
    };
    return SmeupServiceResponse(
        true,
        Response(
            data: messages,
            statusCode: HttpStatus.accepted,
            requestOptions: RequestOptions(path: '')));
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in deleteDocument: $e',
        logType: LogType.error);
    return SmeupServiceResponse(
        false,
        Response(
            data: null,
            statusCode: HttpStatus.badRequest,
            requestOptions: RequestOptions(path: '')));
  }
}
```







