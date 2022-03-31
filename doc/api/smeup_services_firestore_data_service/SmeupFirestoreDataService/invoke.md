


# invoke method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)> invoke
([SmeupFun](../../smeup_models_smeup_fun/SmeupFun-class.md) fun)

_override_






## Implementation

```dart
@override
Future<SmeupServiceResponse> invoke(SmeupFun fun) async {
  switch (fun.fun['fun']['function']) {
    case "GET.DOCUMENTS":
      return await getDocuments(fun);
    case "GET.DOCUMENT":
      return await getDocument(fun);
    case "GET.DOCUMENT.DEFAULT":
      return await getDocumentDefault(fun);
    case "UPDATE.DOCUMENT":
      return await updateDocument(fun);
    case "DELETE.DOCUMENT":
      return await deleteDocument(fun);
    case "WRITE.DOCUMENT":
      return await writeDocument(fun);
    default:
      return null;
  }
}
```







