


# initInternalService method




    *[<Null safety>](https://dart.dev/null-safety)*




dynamic initInternalService
()








## Implementation

```dart
static initInternalService() {
  SmeupDataService.services['*JSN'] = SmeupJsonDataService();
  SmeupDataService.services['*MSG'] = SmeupMessageDataService();
  SmeupDataService.services['*IMAGE'] = SmeupImageDataService();
  SmeupDataService.services['*HTTP'] = SmeupHttpDataService();
}
```







