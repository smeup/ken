


# getInputPanel method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> getInputPanel
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun)








## Implementation

```dart
Future<SmeupServiceResponse> getInputPanel(Fun smeupFun) async {
  try {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';

    final options =
        GetOptions(source: await SmeupFirestoreShared.getSource());

    final fieldsCollection = list
        .firstWhereOrNull((element) => element['key'] == 'fieldsCollection');
    final fields =
        list.firstWhereOrNull((element) => element['key'] == 'fields');
    final id = list.firstWhereOrNull((element) => element['key'] == 'id');
    final dataCollection = list
        .firstWhereOrNull((element) => element['key'] == 'dataCollection');

    if (!_isParValid(fieldsCollection)) {
      checkResult = 'The fieldsCollection is empty. FUN: $smeupFun';
    }

    var isModify = false;
    var isIdPresent = false;
    var isDataCollectionPresent = false;
    if (_isParValid(id)) {
      isIdPresent = true;
    }
    if (_isParValid(dataCollection)) {
      isDataCollectionPresent = true;
    }

    if (isIdPresent & !isDataCollectionPresent ||
        !isIdPresent & isDataCollectionPresent) {
      checkResult =
          'The idCollection and id must be both empty or filled. FUN: $smeupFun';
    }

    if (isIdPresent & isDataCollectionPresent) {
      isModify = true;
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    Query<Map<String, dynamic>> query =
        fsDatabase.collection(fieldsCollection!['value']);

    QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

    dynamic responseData;
    dynamic res;

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      res = getTransformer()!.transform(smeupFun, snapshot);

      responseData = SmeupDataService.getEmptyDataStructure();
      responseData["columns"] = [];
      responseData["rows"] = [];

      var responseRow = Map();

      if ((res['rows'] as List).isNotEmpty) {
        List fieldsArray = [];
        List cnd = [];

        if (_isParValid(fields)) {
          fieldsArray = fields!['value'].toString().split(';');
        }

        final conditionValue = list.firstWhereOrNull(
            (element) => element['key'] == 'conditionValue');
        final conditionField = list.firstWhereOrNull(
            (element) => element['key'] == 'conditionField');
        final conditionsCollection = list.firstWhereOrNull(
            (element) => element['key'] == 'conditionsCollection');
        var hasCondition = false;
        if (_isParValid(conditionValue) &&
            _isParValid(conditionField) &&
            _isParValid(conditionsCollection)) {
          hasCondition = true;
        }

        if (hasCondition) {
          final conditionFieldName = conditionField!['value'];
          final conditionFieldValue = SmeupVariablesService.getVariable(
              conditionFieldName,
              formKey: smeupFun.formKey);
          try {
            Query<Map<String, dynamic>> queryCondition =
                fsDatabase.collection(conditionsCollection!['value']);
            queryCondition = queryCondition.where("conditionField",
                isEqualTo: conditionFieldName);
            queryCondition = queryCondition.where("conditionValue",
                isEqualTo: conditionFieldValue);
            QuerySnapshot<Map<String, dynamic>> snapshotCondition =
                await queryCondition.get(options);
            final resCondition =
                getTransformer()!.transform(smeupFun, snapshotCondition);
            final conditionList = resCondition!['rows'] as List;
            if (conditionList.isNotEmpty)
              cnd = conditionList[0]['fields'].toString().split(';');
          } catch (e) {}
        }

        var idRow = {};
        if (isModify) {
          DocumentSnapshot<Map<String, dynamic>> snapshotDocument =
              await fsDatabase
                  .collection(dataCollection!['value'])
                  .doc(id!['value'])
                  .get(options);
          final resId =
              getTransformer()!.transform(smeupFun, snapshotDocument);
          idRow = resId!['rows'][0];
        }

        responseRow["fields"] = Map();

        var positions = List<dynamic>.empty(growable: true);
        for (var row in (res['rows'] as List)) {
          int position = 0;

          if (cnd.isNotEmpty || fieldsArray.isNotEmpty) {
            bool isCnd = false;
            bool isFields = false;
            if (cnd.contains(row["code"]))
              isCnd = true;
            else if (fieldsArray.contains(row["code"])) isFields = true;

            if (!isCnd & !isFields) {
              continue;
            }

            if (isFields)
              position = fieldsArray.indexOf(row["code"]) + 1;
            else
              position = fieldsArray.length + cnd.indexOf(row["code"]) + 1;
          }

          if (position == 0) {
            position = int.tryParse(row['id']) ?? 0;
          }
          positions.add({"code": row["code"], "position": position});
        }

        for (var row in (res['rows'] as List)) {
          Map<String, dynamic>? col = positions.firstWhere(
              (element) => element['code'] == row["code"],
              orElse: () => null);
          if (col == null) {
            continue;
          }

          (responseData["columns"] as List).add({
            "code": row["code"],
            "IO": row["io"],
            "text": row["text"],
            "position": col['position']
          });

          var value = '';
          if (isModify) {
            value = idRow[row["code"]] ?? '';
          } else {
            value = row["value"] ?? '';
          }

          responseRow["fields"][row["code"]] = {
            "name": row["code"],
            "ogg": row["ogg"],
            "value": value,
            "validation": row["validation"]
          };
        }

        (responseData["rows"] as List).add(responseRow);
      }
    } else {
      final message =
          'SmeupFirestoreDataService.getInputPanel: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
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
        'SmeupFirestoreDataService.getInputPanel: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
    return _getErrorResponse(message);
  }
}
```







