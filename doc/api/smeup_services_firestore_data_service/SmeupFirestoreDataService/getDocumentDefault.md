


# getDocumentDefault method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getDocumentDefault
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getDocumentDefault(SmeupFun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    final fieldId = list.firstWhere((element) => element['key'] == 'fieldId',
        orElse: () => null);

    final key = smeupFun.fun['fun']['parentFun'];

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    if (fieldId == null || fieldId.toString().isEmpty) {
      throw Exception('The fieldId is empty. FUN: $smeupFun');
    }

    if (key == null || key.toString().isEmpty) {
      throw Exception('The key is empty. FUN: $smeupFun');
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
        .collection(collection['value'])
        .where('key', isEqualTo: key)
        .where('fieldId', isEqualTo: fieldId['value'])
        .get(options);

    dynamic responseData;

    if (snapshot == null || snapshot.docs.length == 0) {
      throw Exception(
          'key $key for the fieldId $fieldId not found. FUN: $smeupFun');
    }

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer().transform(smeupFun, snapshot);
    } else {
      final message =
          'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
      responseData = _getErrorResponse(message);
    }

    return SmeupServiceResponse(
        true,
        Response(
            data: responseData,
            statusCode: HttpStatus.accepted,
            requestOptions: null));
  } catch (e) {
    final message =
        'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







