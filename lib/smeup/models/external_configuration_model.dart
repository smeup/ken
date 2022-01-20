class ExternalConfigurationModel {
  String organizationId;
  String description;
  String theme;
  bool showLoader;
  String defaultServiceUserName;
  String defaultServicePassword;
  String defaultServiceEndpoint;
  String httpServiceEndpoint;
  String httpServiceCheckEndpoint;
  bool enableCheckWiFi;
  bool enableCheckDataService;

  ExternalConfigurationModel.fromMap(dynamic json) {
    organizationId = json['organizationId'] ?? '';
    description = json['description'] ?? '';
    theme = json['theme'] ?? 'smeup_theme.json';
    showLoader = json['showLoader'] ?? false;
    defaultServiceEndpoint = json['defaultServiceEndpoint'] ?? '';
    httpServiceEndpoint = json['httpServiceEndpoint'] ?? '';
    httpServiceCheckEndpoint = json['httpServiceCheckEndpoint'] ?? '';
    enableCheckWiFi = json['enableCheckWiFi'] ?? true;
    enableCheckDataService = json['enableCheckDataService'] ?? true;
  }
}
