


# updateDocument method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> updateDocument
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> updateDocument(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';

    final dataCollection = list
        .firstWhereOrNull((element) => element['key'] == 'dataCollection');

    final id = list.firstWhereOrNull((element) => element['key'] == 'id');

    if (!_isParValid(dataCollection)) {
      checkResult = 'The dataCollection is empty. FUN: $smeupFun';
    }

    if (!_isParValid(id)) {
      checkResult = 'The id is empty. FUN: $smeupFun';
    }

    var formFields = Map<String, dynamic>();

    for (var field in list) {
      if (field['key'] == 'dataCollection') continue;
      if (field['key'] == 'id') continue;
      formFields[field['key']] = field['value'];
    }

    if (formFields.entries.isEmpty) {
      checkResult = 'The list of fields to update is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    bool isOnLine = await SmeupFirestoreShared.isInternetOn();

    if (isOnLine) {
      await fsDatabase
          .collection(dataCollection!['value'])
          .doc(id!['value'])
          .update(formFields);
    } else {
      fsDatabase
          .collection(dataCollection!['value'])
          .doc(id!['value'])
          .update(formFields);
    }

    final messages = {
      "messages": [
        {
          "gravity": isOnLine ? LogType.info : LogType.warning,
          "message":
              "${SmeupConfigurationService.appDictionary.getLocalString('updateCompletedSuccessfully')} ${isOnLine ? '' : 'offline'}",
        }
      ]
    };
    return SmeupServiceResponse(
        true,
        Response(
            data: messages,
            statusCode: HttpStatus.accepted,
            requestOptions: RequestOptions(path: '')));
  } catch (e, stacktrace) {
    SmeupLogService.writeDebugMessage(
        'Error in updateDocument: $e $stacktrace',
        logType: LogType.error);
    final messages = {
      "messages": [
        {
          "gravity": LogType.error,
          "message": SmeupConfigurationService.appDictionary
              .getLocalString('errorWritingInformation'),
        }
      ]
    };
    return SmeupServiceResponse(
        false,
        Response(
            data: messages,
            statusCode: HttpStatus.badRequest,
            requestOptions: RequestOptions(path: '')));
  }
}
```







