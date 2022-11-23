


# SmeupDataServiceInterface constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupDataServiceInterface([SmeupDataTransformerInterface](../../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md)? transformer)





## Implementation

```dart
SmeupDataServiceInterface(SmeupDataTransformerInterface? transformer) {
  if (transformer == null) transformer = NullTransformer();
  this.transformer = transformer;
}
```







