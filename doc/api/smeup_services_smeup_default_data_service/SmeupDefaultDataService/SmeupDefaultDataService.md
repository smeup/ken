


# SmeupDefaultDataService constructor







SmeupDefaultDataService()





## Implementation

```dart
SmeupDefaultDataService() {
  BaseOptions options = new BaseOptions(
    connectTimeout: DEFAULD_TIMEOUT,
    receiveTimeout: DEFAULD_TIMEOUT,
  );
  dio = Dio(options);
}
```







