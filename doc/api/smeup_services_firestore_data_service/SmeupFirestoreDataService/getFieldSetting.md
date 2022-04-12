


# getFieldSetting method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getFieldSetting
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getFieldSetting(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> parameters = smeupFun.parameters;
    List<Map<String, dynamic>> server = smeupFun.server;
    var checkResult = '';

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection = parameters
        .firstWhereOrNull((element) => element['key'] == 'collection');

    Map<String, dynamic>? fieldPath = Map<String, dynamic>();

    fieldPath = parameters
        .firstWhereOrNull((element) => element['key'] == 'fieldPath');

    if (fieldPath == null) {
      fieldPath =
          server.firstWhereOrNull((element) => element['key'] == 'fieldPath');
    }

    if (collection == null || collection.toString().isEmpty) {
      checkResult = 'The collection is empty. FUN: $smeupFun';
    }

    if (fieldPath == null || fieldPath.toString().isEmpty) {
      checkResult = 'The fieldId is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
        .collection(collection!['value'])
        //.where('key', isEqualTo: key)
        .where('fieldId', isEqualTo: fieldPath!['value'])
        .get(options);

    dynamic responseData;

    if (snapshot.docs.length == 0) {
      checkResult = 'fieldId $fieldPath not found. FUN: $smeupFun';
      return _getErrorResponse(checkResult);
    }

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer()!.transform(smeupFun, snapshot);
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
            requestOptions: RequestOptions(path: '')));
  } catch (e) {
    final message =
        'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







