import 'package:flutter/material.dart';

class KenConfigurationService {
  static const double staticButtonRoundness = 0.0;

  static ThemeData? _theme;
  static Map<DateTime, List?>? holidays;

  static dynamic appDictionary;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static String? jsonsPath;
  static String? imagesPath;
  static late String appBarImage;
  static bool? defaultAutoAdaptHeight;

  static Future<void> init(BuildContext? context,
      {dynamic localizationService,
      String appBarImage = '',
      bool isLogEnabled = false,
      Map<DateTime, List?>? holidays,
      String? jsonsPath,
      String? imagesPath,
      ThemeData? theme,
      bool defaultAutoAdaptHeight = true}) async {
    KenConfigurationService.holidays = holidays;
    KenConfigurationService._theme = theme;
    KenConfigurationService.isLogEnabled = isLogEnabled;
    KenConfigurationService.defaultAutoAdaptHeight = defaultAutoAdaptHeight;
    KenConfigurationService.appBarImage = appBarImage;

    KenConfigurationService.appDictionary = localizationService;

    KenConfigurationService.jsonsPath = jsonsPath;
    KenConfigurationService.imagesPath = imagesPath;

    //if (KenConfigurationService.isLogEnabled) await KenLogService.setLogFile();
  }

  static ThemeData? getTheme() {
    return KenConfigurationService._theme;
  }
}
