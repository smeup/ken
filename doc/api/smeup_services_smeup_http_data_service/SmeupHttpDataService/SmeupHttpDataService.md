


# SmeupHttpDataService constructor







SmeupHttpDataService()





## Implementation

```dart
SmeupHttpDataService() {
  BaseOptions options = new BaseOptions(
    connectTimeout: DEFAULD_TIMEOUT,
    receiveTimeout: DEFAULD_TIMEOUT,
  );
  dio = Dio(options);
}
```







