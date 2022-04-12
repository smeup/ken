


# getFromFirestore method




    *[<Null safety>](https://dart.dev/null-safety)*




[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[String](https://api.flutter.dev/flutter/dart-core/String-class.html)> getFromFirestore
([Fun](../../smeup_models_fun/Fun-class.md) smeupFun, dynamic fileName)








## Implementation

```dart
Future<String> getFromFirestore(Fun smeupFun, fileName) async {
  if (firestoreInstance == null)
    throw Exception('Firebase instance not valid');

  List<Map<String, dynamic>> list = smeupFun.server;

  final options = GetOptions(source: await FirestoreShared.getSource());

  final collection =
      list.firstWhereOrNull((element) => element['key'] == 'collection');

  if (collection == null) {
    final msg = 'The collection is empty';
    SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
    throw Exception(msg);
  }

  QuerySnapshot<Map<String, dynamic>> snapshot = await firestoreInstance!
      .collection(collection['value'])
      .where('formId', isEqualTo: fileName)
      .get(options);

  dynamic responseData;

  // Apply transformation to service response (only on success)
  if (getTransformer() is NullTransformer == false) {
    responseData = getTransformer()!.transform(smeupFun, snapshot);
  } else {
    final msg = 'No transformer defined in the service';
    SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
    throw Exception(msg);
  }

  SmeupLogService.writeDebugMessage(
      '*** \'SmeupJsonDataService\' getFromFirestore. collection: ${collection['value']}; form: $fileName');

  return jsonEncode(responseData);
}
```







