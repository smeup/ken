


# writeDocument method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> writeDocument
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> writeDocument(SmeupFun smeupFun) async {
  List<Map<String, dynamic>> list = smeupFun.getParameters();

  final collection = list.firstWhere(
      (element) => element['key'] == 'collection',
      orElse: () => null);

  final parFields = list.firstWhere(
      (element) => element['key'] == FIRESTORE_FIELDS,
      orElse: () => null);

  if (collection == null || collection.toString().isEmpty) {
    throw Exception('The collection is empty. FUN: $smeupFun');
  }

  if (parFields == null || parFields.isEmpty) {
    throw Exception('The $FIRESTORE_FIELDS is empty. FUN: $smeupFun');
  }

  List<String> firestoreFields = parFields['value'].toString().split(',');

  final checkResult = _checkDocument(smeupFun);
  if (checkResult.isNotEmpty) {
    final messages = {
      "messages": [
        {
          "gravity": LogType.error,
          "message": checkResult,
        }
      ]
    };
    return SmeupServiceResponse(
        false,
        Response(
            data: messages,
            statusCode: HttpStatus.badRequest,
            requestOptions: null));
  }

  try {
    var formInputFields = _getFirestoreFields(smeupFun, firestoreFields);

    bool isOnLine = await FirestoreShared.isInternetOn();

    if (isOnLine) {
      final docRef = await fsDatabase
          .collection(collection['value'])
          .add(formInputFields);

      if (docRef != null) {
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
                requestOptions: null));
      } else {
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
                statusCode: HttpStatus.accepted,
                requestOptions: null));
      }
    } else {
      fsDatabase.collection(collection['value']).add(formInputFields);
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
              requestOptions: null));
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
            requestOptions: null));
  }
}
```







