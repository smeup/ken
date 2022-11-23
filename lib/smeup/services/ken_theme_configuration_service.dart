import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:ken/smeup/services/ken_log_service.dart';
import 'package:ken/smeup/services/ken_localization_service.dart';
import 'package:package_info/package_info.dart';

import '../models/external_configuration_model.dart';

class KenThemeConfigurationService {
  static const double STATIC_BUTTON_ROUNDNESS = 0.0;

  static ThemeData? _theme;
  static PackageInfo? _packageInfo;
  static Map<DateTime, List?>? _holidays;

  static KenLogType? logLevel;

  static dynamic appDictionary;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static String? jsonsPath;
  static String? imagesPath;
  static ExternalConfigurationModel? _appConfiguration;
  static late String appBarImage;
  static bool? defaultAutoAdaptHeight;

  static PackageInfo packageInfoModel = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  static Future<void> init(BuildContext? context,
      {KenLogType logLevel = KenLogType.none,
        dynamic localizationService,
        String appBarImage = '',
        bool defaultAutoAdaptHeight = true}) async {
    await KenThemeConfigurationService.setAppConfiguration();

    KenThemeConfigurationService.defaultAutoAdaptHeight = defaultAutoAdaptHeight;
    KenThemeConfigurationService.logLevel = logLevel;
    KenThemeConfigurationService.appBarImage = appBarImage;

    KenThemeConfigurationService.appDictionary = localizationService;

    await KenThemeConfigurationService.setTheme(
        KenThemeConfigurationService.getAppConfiguration()?.theme ?? '');


    KenThemeConfigurationService.jsonsPath = 'assets/jsons';
    KenThemeConfigurationService.imagesPath = 'assets/images';

    if (KenThemeConfigurationService.isLogEnabled)
      await KenLogService.setLogFile();


    if (context != null) KenThemeConfigurationService.setHolidays(context);

  }

  static setHolidays(context) {
    try {
      if (KenLocalizationService.of(context) != null) {
        KenLocalizationService.of(context)!
            .getHolidays(DateTime.now().year,
                Localizations.localeOf(context).countryCode)
            .then((holidays) {
          KenThemeConfigurationService._holidays = holidays;
        });
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: KenLogType.error);
    }
  }

  static Map<DateTime, List<dynamic>?>? getHolidays() {
    return KenThemeConfigurationService._holidays;
  }

  static setTheme(String themeFile) async {
    try {
      if (themeFile.isNotEmpty) {
        String themeStr =
            await rootBundle.loadString('assets/jsons/themes/$themeFile');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson, validate: false);
        KenLogService.writeDebugMessage('Loaded $themeFile theme file');
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: KenLogType.error);
    } finally {
      if (_theme == null) {
        String themeStr = await rootBundle
            .loadString('assets/jsons/themes/smeup_theme.json');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson);
        // print(_theme);
      }
    }
  }

  static ThemeData? getTheme() {
    return KenThemeConfigurationService._theme;
  }

  static setAppConfiguration() async {
    try {
      String jsonString =
      await rootBundle.loadString('assets/jsons/config.json');
      _appConfiguration =
          ExternalConfigurationModel.fromMap(jsonDecode(jsonString));
      KenLogService.writeDebugMessage('Loaded config.json');
    } catch (e) {
      KenLogService.writeDebugMessage('Error in getAppConfig: $e',
          logType: KenLogType.error);
    }
  }

  static ExternalConfigurationModel? getAppConfiguration() {
    return _appConfiguration;
  }

}
