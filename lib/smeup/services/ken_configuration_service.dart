import 'package:flutter/material.dart';

import '../models/external_configuration_model.dart';
import 'ken_log_service.dart';

class KenConfigurationService {
  static const double STATIC_BUTTON_ROUNDNESS = 0.0;

  static ThemeData? _theme;
  static Map<DateTime, List?>? holidays;

  static KenLogType? logLevel;

  static dynamic appDictionary;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static String? jsonsPath;
  static String? imagesPath;
  static ExternalConfigurationModel? externalConfigurationModel;
  static late String appBarImage;
  static bool? defaultAutoAdaptHeight;

  static Future<void> init(BuildContext? context,
      {KenLogType logLevel = KenLogType.none,
      dynamic localizationService,
      String appBarImage = '',
      bool isLogEnabled = false,
      Map<DateTime, List?>? holidays,
      String? jsonsPath,
      String? imagesPath,
      ExternalConfigurationModel? appConfiguration,
      ThemeData? theme,
      bool defaultAutoAdaptHeight = true}) async {
    KenConfigurationService.externalConfigurationModel = appConfiguration;
    KenConfigurationService.holidays = holidays;
    KenConfigurationService._theme = theme;
    KenConfigurationService.isLogEnabled = isLogEnabled;
    KenConfigurationService.defaultAutoAdaptHeight = defaultAutoAdaptHeight;
    KenConfigurationService.logLevel = logLevel;
    KenConfigurationService.appBarImage = appBarImage;

    KenConfigurationService.appDictionary = localizationService;

    KenConfigurationService.jsonsPath = jsonsPath;
    KenConfigurationService.imagesPath = imagesPath;

    if (KenConfigurationService.isLogEnabled) await KenLogService.setLogFile();
  }

  static ThemeData? getTheme() {
    return KenConfigurationService._theme;
  }
}
