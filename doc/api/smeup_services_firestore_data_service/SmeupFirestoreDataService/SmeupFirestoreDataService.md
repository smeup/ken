


# SmeupFirestoreDataService constructor




    *[<Null safety>](https://dart.dev/null-safety)*



SmeupFirestoreDataService([FirebaseFirestore](https://pub.dev/documentation/cloud_firestore/3.1.11/cloud_firestore/FirebaseFirestore-class.html) fsDatabase, {[SmeupDataTransformerInterface](../../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md)? transformer})





## Implementation

```dart
SmeupFirestoreDataService(this.fsDatabase,
    {SmeupDataTransformerInterface? transformer})
    : super(transformer) {
  fsDatabase.settings = const Settings(persistenceEnabled: true);
}
```







