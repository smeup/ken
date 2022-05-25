


# getDocument method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getDocument
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getDocument(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';

    final options =
        GetOptions(source: await SmeupFirestoreShared.getSource());

    final dataCollection = list
        .firstWhereOrNull((element) => element['key'] == 'dataCollection');

    final id = list.firstWhereOrNull((element) => element['key'] == 'id');

    if (!_isParValid(dataCollection)) {
      checkResult = 'The dataCollection is empty. FUN: $smeupFun';
    }

    if (!_isParValid(id)) {
      checkResult = 'The id is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    DocumentSnapshot<Map<String, dynamic>> snapshot = await fsDatabase
        .collection(dataCollection!['value'])
        .doc(id!['value'])
        .get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer()!.transform(smeupFun, snapshot);
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
            requestOptions: RequestOptions(path: '')));
  } catch (e) {
    final message =
        'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







