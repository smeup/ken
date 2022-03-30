


# updateDocument method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> updateDocument
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> updateDocument(SmeupFun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    final id = list.firstWhere((element) => element['key'] == 'id',
        orElse: () => null);

    final parFields = list.firstWhere(
        (element) => element['key'] == FIRESTORE_FIELDS,
        orElse: () => null);

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    if (id == null || id.toString().isEmpty) {
      throw Exception('The id is empty. FUN: $smeupFun');
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

    var formInputFields = _getFirestoreFields(smeupFun, firestoreFields);

    bool isOnLine = await FirestoreShared.isInternetOn();

    if (isOnLine) {
      await fsDatabase
          .collection(collection['value'])
          .doc(id['value'])
          .update(formInputFields);
    } else {
      fsDatabase
          .collection(collection['value'])
          .doc(id['value'])
          .update(formInputFields);
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
            requestOptions: null));
  } catch (e) {
    SmeupLogService.writeDebugMessage('Error in updateDocument: $e',
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







