


# SmeupHttpDataService constructor







SmeupHttpDataService([SmeupDataTransformerInterface](../../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md) transformer)





## Implementation

```dart
SmeupHttpDataService(SmeupDataTransformerInterface transformer)
    : super(transformer) {
  BaseOptions options = new BaseOptions(
    connectTimeout: DEFAULD_TIMEOUT,
    receiveTimeout: DEFAULD_TIMEOUT,
  );
  dio = Dio(options);
}
```







