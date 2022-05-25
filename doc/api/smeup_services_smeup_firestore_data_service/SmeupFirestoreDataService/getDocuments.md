


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

    final options =
        GetOptions(source: await SmeupFirestoreShared.getSource());

    final dataCollection = list
        .firstWhereOrNull((element) => element['key'] == 'dataCollection');

    final filters =
        list.firstWhereOrNull((element) => element['key'] == 'filters');

    final sort = list.firstWhereOrNull((element) => element['key'] == 'sort');

    if (!_isParValid(dataCollection)) {
      checkResult = 'The dataCollection is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    Query<Map<String, dynamic>> query =
        fsDatabase.collection(dataCollection!['value']);

    if (_isParValid(filters)) {
      var parmsSplit = Fun.splitParameters(filters!['value']);
      parmsSplit.forEach((element) {
        Map ds = Fun.deserilizeParameter(element);
        final key = ds['key'];
        var value = ds['value'];
        query = query.where(key, isEqualTo: value);
      });
    }

    if (_isParValid(sort)) {
      var parmsSplit = Fun.splitParameters(sort!['value']);
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

    final fieldsCollection = list
        .firstWhereOrNull((element) => element['key'] == 'fieldsCollection');

    if (_isParValid(fieldsCollection)) {
      try {
        Query<Map<String, dynamic>> queryFields =
            fsDatabase.collection(fieldsCollection!['value']);
        QuerySnapshot<Map<String, dynamic>> snapshotFields =
            await queryFields.get(options);
        final resFields =
            getTransformer()!.transform(smeupFun, snapshotFields);
        final fieldsList = resFields!['rows'] as List;
        if (fieldsList.isNotEmpty) {
          (responseData["columns"] as List).forEach((col) {
            var field = fieldsList.firstWhere(
                (element) => element['code'] == col['code'],
                orElse: () => null);
            if (field != null) {
              col['cmp'] = field['cmp'];
              col['text'] = field['text'];
              col['ogg'] = field['ogg'];
              col['IO'] = field['io'] == 'H' ? 'H' : 'O';
            }
          });
        }
      } catch (e) {}
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







