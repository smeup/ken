


# setData method




    *[<Null safety>](https://dart.dev/null-safety)*



- @[override](https://api.flutter.dev/flutter/dart-core/override-constant.html)

dynamic setData
()








## Implementation

```dart
@override
// ignore: override_on_non_overriding_member
setData() async {
  if (smeupFun != null && smeupFun!.isFunValid()) {
    final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);

    if (!smeupServiceResponse.succeded) {
      try {
        serviceStatusCode = smeupServiceResponse.result.statusCode;
      } catch (e) {}
      return;
    }

    data = smeupServiceResponse.result.data;

    if (data['isDialog'] != null)
      isDialog = SmeupUtilities.getBool(data['isDialog']);
    if (data['backButtonVisible'] != null)
      backButtonVisible = SmeupUtilities.getBool(data['backButtonVisible']);

    try {
      serviceStatusCode = smeupServiceResponse.result.statusCode;
    } catch (e) {}
  }
}
```







