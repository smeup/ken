


# setData method







- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic setData
()








## Implementation

```dart
@override
// ignore: override_on_non_overriding_member
setData() async {
  if (smeupFun != null && smeupFun.isFunValid()) {
    final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

    if (!smeupServiceResponse.succeded) {
      try {
        serviceStatusCode = smeupServiceResponse.result.statusCode;
      } catch (e) {}
      return;
    }

    data = smeupServiceResponse.result.data;

    isDialog = SmeupUtilities.getBool(data['isDialog']) ?? defaultIsDialog;
    backButtonVisible = SmeupUtilities.getBool(data['backButtonVisible']) ??
        defaultBackButtonVisible;

    try {
      serviceStatusCode = smeupServiceResponse.result.statusCode;
    } catch (e) {}
  }
}
```







