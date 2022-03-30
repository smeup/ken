


# getDocuments method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getDocuments
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getDocuments(SmeupFun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
        .collection(collection['value'])
        //.orderBy(orderBy, descending: true)
        .get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (snapshot != null && getTransformer() is NullTransformer == false) {
      responseData = getTransformer().transform(smeupFun, snapshot);
    } else {
      final message =
          'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
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
        'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







