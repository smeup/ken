


# SmeupFirestoreDataService class






    *[<Null safety>](https://dart.dev/null-safety)*





**Inheritance**

- [Object](https://api.flutter.dev/flutter/dart-core/Object-class.html)
- [SmeupDataServiceInterface](../smeup_services_smeup_data_service_interface/SmeupDataServiceInterface-class.md)
- SmeupFirestoreDataService






## Constructors

[SmeupFirestoreDataService](../smeup_services_firestore_data_service/SmeupFirestoreDataService/SmeupFirestoreDataService.md) ([FirebaseFirestore](https://pub.dev/documentation/cloud_firestore/3.1.11/cloud_firestore/FirebaseFirestore-class.html) fsDatabase, {[SmeupDataTransformerInterface](../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md)? transformer})

    


## Properties

##### [fsDatabase](../smeup_services_firestore_data_service/SmeupFirestoreDataService/fsDatabase.md) &#8596; [FirebaseFirestore](https://pub.dev/documentation/cloud_firestore/3.1.11/cloud_firestore/FirebaseFirestore-class.html)



   
_read / write_



##### [hashCode](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html) &#8594; [int](https://api.flutter.dev/flutter/dart-core/int-class.html)



The hash code for this object. [...](https://api.flutter.dev/flutter/dart-core/Object/hashCode.html)  
_read-only, inherited_



##### [runtimeType](https://api.flutter.dev/flutter/dart-core/Object/runtimeType.html) &#8594; [Type](https://api.flutter.dev/flutter/dart-core/Type-class.html)



A representation of the runtime type of the object.   
_read-only, inherited_



##### [transformer](../smeup_services_smeup_data_service_interface/SmeupDataServiceInterface/transformer.md) &#8596; [SmeupDataTransformerInterface](../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md)?



   
_read / write, inherited_




## Methods

##### [deleteDocument](../smeup_services_firestore_data_service/SmeupFirestoreDataService/deleteDocument.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   




##### [getDocument](../smeup_services_firestore_data_service/SmeupFirestoreDataService/getDocument.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   




##### [getDocuments](../smeup_services_firestore_data_service/SmeupFirestoreDataService/getDocuments.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   




##### [getFieldSetting](../smeup_services_firestore_data_service/SmeupFirestoreDataService/getFieldSetting.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   




##### [getTransformer](../smeup_services_smeup_data_service_interface/SmeupDataServiceInterface/getTransformer.md)() [SmeupDataTransformerInterface](../smeup_services_transformers_smeup_data_transformer_interface/SmeupDataTransformerInterface-class.md)?



   
_inherited_



##### [invoke](../smeup_services_firestore_data_service/SmeupFirestoreDataService/invoke.md)([Fun](../smeup_models_fun/Fun-class.md) fun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   
_override_



##### [noSuchMethod](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)([Invocation](https://api.flutter.dev/flutter/dart-core/Invocation-class.html) invocation) dynamic



Invoked when a non-existent method or property is accessed. [...](https://api.flutter.dev/flutter/dart-core/Object/noSuchMethod.html)  
_inherited_



##### [toString](https://api.flutter.dev/flutter/dart-core/Object/toString.html)() [String](https://api.flutter.dev/flutter/dart-core/String-class.html)



A string representation of this object. [...](https://api.flutter.dev/flutter/dart-core/Object/toString.html)  
_inherited_



##### [updateDocument](../smeup_services_firestore_data_service/SmeupFirestoreDataService/updateDocument.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   




##### [writeDocument](../smeup_services_firestore_data_service/SmeupFirestoreDataService/writeDocument.md)([Fun](../smeup_models_fun/Fun-class.md) smeupFun) [Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[SmeupServiceResponse](../smeup_services_smeup_service_response/SmeupServiceResponse-class.md)>



   





## Operators

##### [operator ==](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)([Object](https://api.flutter.dev/flutter/dart-core/Object-class.html) other) [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html)



The equality operator. [...](https://api.flutter.dev/flutter/dart-core/Object/operator_equals.html)  
_inherited_











