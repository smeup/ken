


# initInternalService method








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







