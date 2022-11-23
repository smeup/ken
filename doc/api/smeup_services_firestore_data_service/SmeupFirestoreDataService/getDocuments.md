


# getDocuments method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getDocuments
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getDocuments(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection =
        list.firstWhereOrNull((element) => element['key'] == 'collection');

    final filters =
        list.firstWhereOrNull((element) => element['key'] == 'filters');

    final sort = list.firstWhereOrNull((element) => element['key'] == 'sort');

    if (collection == null || collection.toString().isEmpty) {
      checkResult = 'The collection is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    Query<Map<String, dynamic>> query =
        fsDatabase.collection(collection!['value']);

    if (filters != null && filters.toString().isNotEmpty) {
      var parmsSplit = Fun.splitParameters(filters['value']);
      parmsSplit.forEach((element) {
        Map ds = Fun.deserilizeParameter(element);
        final key = ds['key'];
        var value = ds['value'];
        query = query.where(key, isEqualTo: value);
      });
    }

    if (sort != null && sort.toString().isNotEmpty) {
      var parmsSplit = Fun.splitParameters(sort['value']);
      parmsSplit.forEach((element) {
        Map ds = Fun.deserilizeParameter(element);
        final key = ds['key'];
        var descending = ds['value'] == 'descending';
        query = query.orderBy(key, descending: descending);
      });
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer()!.transform(smeupFun, snapshot);
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
            requestOptions: RequestOptions(path: '')));
  } catch (e) {
    final message =
        'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







