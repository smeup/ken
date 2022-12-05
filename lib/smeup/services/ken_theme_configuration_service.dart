import 'package:flutter/material.dart';
import 'package:ken/smeup/services/ken_log_service.dart';

import '../models/external_configuration_model.dart';

class KenThemeConfigurationService {
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
      Map<DateTime, List?>? holidays,
      String? jsonsPath,
      String? imagesPath,
      ExternalConfigurationModel? appConfiguration,
      ThemeData? theme,
      bool defaultAutoAdaptHeight = true}) async {
    KenThemeConfigurationService.externalConfigurationModel = appConfiguration;
    KenThemeConfigurationService.holidays = holidays;
    KenThemeConfigurationService._theme = theme;

    KenThemeConfigurationService.defaultAutoAdaptHeight =
        defaultAutoAdaptHeight;
    KenThemeConfigurationService.logLevel = logLevel;
    KenThemeConfigurationService.appBarImage = appBarImage;

    KenThemeConfigurationService.appDictionary = localizationService;

    KenThemeConfigurationService.jsonsPath = jsonsPath;
    KenThemeConfigurationService.imagesPath = imagesPath;

    if (KenThemeConfigurationService.isLogEnabled)
      await KenLogService.setLogFile();
  }

  static ThemeData? getTheme() {
    return KenThemeConfigurationService._theme;
  }
}
