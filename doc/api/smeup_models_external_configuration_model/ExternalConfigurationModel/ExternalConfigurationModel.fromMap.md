


# ExternalConfigurationModel.fromMap constructor







ExternalConfigurationModel.fromMap(dynamic json)





## Implementation

```dart
ExternalConfigurationModel.fromMap(dynamic json) {
  organizationId = json['organizationId'] ?? '';
  description = json['description'] ?? '';
  theme = json['theme'] ?? 'tony_blue.json';
  showLoader = json['showLoader'] ?? false;
  defaultServiceEndpoint = json['defaultServiceEndpoint'] ?? '';
  httpServiceEndpoint = json['httpServiceEndpoint'] ?? '';
  httpServiceCheckEndpoint = json['httpServiceCheckEndpoint'] ?? '';
  enableCheckWiFi = json['enableCheckWiFi'] ?? true;
  enableCheckDataService = json['enableCheckDataService'] ?? true;
}
```







