


# getDocument method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getDocument
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getDocument(SmeupFun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    final id = list.firstWhere((element) => element['key'] == 'id',
        orElse: () => null);

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    if (id == null || id.toString().isEmpty) {
      throw Exception('The id is empty. FUN: $smeupFun');
    }

    DocumentSnapshot<Map<String, dynamic>> snapshot = await fsDatabase
        .collection(collection['value'])
        .doc(id['value'])
        .get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (snapshot != null && getTransformer() is NullTransformer == false) {
      responseData = getTransformer().transform(smeupFun, snapshot);
    } else {
      final message =
          'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
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
        'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







