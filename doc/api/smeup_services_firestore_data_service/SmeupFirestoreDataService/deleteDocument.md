


# deleteDocument method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> deleteDocument
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> deleteDocument(SmeupFun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final id = list.firstWhere((element) => element['key'] == 'id',
        orElse: () => null);

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    if (id == null || id.toString().isEmpty) {
      throw Exception('The id is empty. FUN: $smeupFun');
    }

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    bool isOnLine = await FirestoreShared.isInternetOn();

    if (isOnLine) {
      await fsDatabase
          .collection(collection['value'])
          .doc(id['value'])
          .delete();
    } else {
      fsDatabase.collection(collection['value']).doc(id['value']).delete();
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
            requestOptions: null));
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in deleteDocument: $e',
        logType: LogType.error);
    return SmeupServiceResponse(
        false,
        Response(
            data: null,
            statusCode: HttpStatus.badRequest,
            requestOptions: null));
  }
}
```







