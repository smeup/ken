


# invoke method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([Fun](../../smeup_models_fun/Fun-class.md) fun)

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(Fun fun) async {
  switch (fun.identifier.function) {
    case "GET.DOCUMENTS":
      return await getDocuments(fun);
    case "GET.DOCUMENT":
      return await getDocument(fun);
    case "GET.FIELD.DEFAULT":
    case "GET.FIELD.VALIDATION":
      return await getFieldSetting(fun);
    case "UPDATE.DOCUMENT":
      return await updateDocument(fun);
    case "DELETE.DOCUMENT":
      return await deleteDocument(fun);
    case "WRITE.DOCUMENT":
      return await writeDocument(fun);
    default:
      final message =
          'SmeupFirestoreDataService.invoke: function not implemented ${fun.toString()}';
      return _getErrorResponse(message);
  }
}
```







