


# writeDocument method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> writeDocument
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> writeDocument(Fun smeupFun) async {
  List<Map<String, dynamic>> list = smeupFun.parameters;
  var checkResult = '';
  final collection =
      list.firstWhereOrNull((element) => element['key'] == 'collection');

  if (collection == null || collection.toString().isEmpty) {
    checkResult = 'The collection is empty. FUN: $smeupFun';
  }

  var formFields = Map<String, dynamic>();

  for (var field in list) {
    if (field['key'] == 'collection') continue;
    formFields[field['key']] = field['value'];
  }

  if (formFields.entries.isEmpty) {
    checkResult = 'The list of fields to update is empty. FUN: $smeupFun';
  }

  //final checkResult = _checkDocument(formFields);
  if (checkResult.isNotEmpty) {
    return _getErrorResponse(checkResult);
  }

  try {
    bool isOnLine = await FirestoreShared.isInternetOn();

    if (isOnLine) {
      final docRef =
          await fsDatabase.collection(collection!['value']).add(formFields);

      SmeupVariablesService.setVariable(
          'id', await docRef.get().then((snapshot) => snapshot.id),
          formKey: smeupFun.formKey);

      final messages = {
        "messages": [
          {
            "gravity": LogType.info,
            "message": SmeupConfigurationService.appDictionary
                .getLocalString('updateCompletedSuccessfully'),
          }
        ]
      };
      return SmeupServiceResponse(
          true,
          Response(
              data: messages,
              statusCode: HttpStatus.accepted,
              requestOptions: RequestOptions(path: '')));
    } else {
      fsDatabase.collection(collection!['value']).add(formFields);
      final messages = {
        "messages": [
          {
            "gravity": LogType.warning,
            "message": SmeupConfigurationService.appDictionary
                .getLocalString('updateSuccessfullyOffline'),
          }
        ]
      };
      return SmeupServiceResponse(
          true,
          Response(
              data: messages,
              statusCode: HttpStatus.accepted,
              requestOptions: RequestOptions(path: '')));
    }
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in writeDocument: $e',
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







