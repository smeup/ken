import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:mobile_components_library/smeup/services/smeup_cache_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service_interface.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';
import 'package:package_info/package_info.dart';
import 'package:mobile_components_library/smeup/services/SmeupLocalizationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/configuration_model.dart';

enum ALT_SERVICE_ENDPOINTS { DEFAULT, HTTP }

class SmeupConfigurationService {
  static const double STATIC_BUTTON_ROUNDNESS = 0.0;
  static LogType logLevel;
  static bool isLoginEnabled = false;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static SharedPreferences _localStorge;
  static ThemeData _theme;
  static String jsonsPath;
  static String imagesPath;
  static String defaultServiceToken = '';
  static String defaultServiceUserName;
  static String defaultServicePassword;
  static String _defaultServiceEndpoint;
  static String _httpServiceEndpoint;
  static Function logoutFunction;
  static PackageInfo _packageInfo;
  // static double deviceHeight;
  // static double deviceWidth;
  static Map<DateTime, List> _holidays;
  static dynamic appDictionary;
  static ConfigurationModel _appConfiguration;
  static Color defaultSplashColor;
  static Color defaultLoaderColor;

  static PackageInfo packageInfoModel = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  static Future<void> init(BuildContext context,
      {LogType logLevel = LogType.none,
      dynamic localizationService,
      Map<String, SmeupDataServiceInterface> customDataServices,
      bool enableCache = false,
      Function logoutFunction,
      Color defaultSplashColor = Colors.white,
      Color defaultLoaderColor = Colors.white}) async {
    await SmeupConfigurationService.setAppConfiguration();

    SmeupConfigurationService.logLevel = logLevel;
    SmeupConfigurationService.defaultSplashColor = defaultSplashColor;
    SmeupConfigurationService.defaultLoaderColor = defaultLoaderColor;

    await SmeupConfigurationService.setTheme(
        SmeupConfigurationService.getAppConfiguration().theme);
    await SmeupConfigurationService.setLocalStorage();
    SmeupConfigurationService.appDictionary = localizationService;

    SmeupConfigurationService.setDefaultServiceEndpoint();
    SmeupConfigurationService.setHttpServiceEndpoint();

    SmeupConfigurationService.jsonsPath = 'assets/jsons';
    SmeupConfigurationService.imagesPath = 'assets/images';

    SmeupDataService.initInternalService();

    if (customDataServices != null) {
      customDataServices.entries.forEach((customService) {
        SmeupDataService.services[customService.key] = customService.value;
      });
    }

    if (SmeupConfigurationService.isLogEnabled)
      await SmeupLogService.setLogFile();

    SmeupConfigurationService.logoutFunction = logoutFunction;
    SmeupConfigurationService.setPackageInfo(packageInfoModel);
    if (context != null) SmeupConfigurationService.setHolidays(context);
    if (enableCache) SmeupCacheService.init();
  }

  static void setPackageInfo(PackageInfo packageInfo) {
    _packageInfo = packageInfo;
    SmeupVariablesService.setVariable(
        '*VERSION', _packageInfo != null ? _packageInfo.version : '');
  }

  static PackageInfo getPackageInfo() {
    return _packageInfo;
  }

  static setHolidays(context) {
    try {
      if (SmeupLocalizationService.of(context) != null) {
        SmeupLocalizationService.of(context)
            .getHolidays(DateTime.now().year,
                Localizations.localeOf(context).countryCode)
            .then((holidays) {
          SmeupConfigurationService._holidays = holidays;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  static Map<DateTime, List<dynamic>> getHolidays() {
    return SmeupConfigurationService._holidays;
  }

  static setTheme(String themeFile) async {
    try {
      if (themeFile.isNotEmpty) {
        String themeStr =
            await rootBundle.loadString('assets/jsons/themes/$themeFile');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson);
        SmeupLogService.writeDebugMessage('Loaded $themeFile theme file');
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: LogType.error);
    }
  }

  static ThemeData getTheme() {
    return SmeupConfigurationService._theme;
  }

  static setAppConfiguration() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/jsons/config.json');
      _appConfiguration = ConfigurationModel.fromMap(jsonDecode(jsonString));
      SmeupLogService.writeDebugMessage('Loaded config.json');
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getAppConfig: $e',
          logType: LogType.error);
    }
  }

  static ConfigurationModel getAppConfiguration() {
    return _appConfiguration;
  }

  static setDefaultServiceEndpoint() {
    // Load service endpoints from shared preferences
    final savedDefaultServiceEndpoint =
        _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.DEFAULT);

    if (savedDefaultServiceEndpoint.isNotEmpty)
      _defaultServiceEndpoint = savedDefaultServiceEndpoint;
    else
      _defaultServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
          .defaultServiceEndpoint;
  }

  static getDefaultServiceEndpoint() {
    return _defaultServiceEndpoint;
  }

  static setHttpServiceEndpoint() {
    final savedHttpServiceEndpoint =
        _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.HTTP);

    if (savedHttpServiceEndpoint.isNotEmpty)
      _httpServiceEndpoint = savedHttpServiceEndpoint;
    else
      _httpServiceEndpoint =
          SmeupConfigurationService.getAppConfiguration().httpServiceEndpoint;
  }

  static getHttpServiceEndpoint() {
    return _httpServiceEndpoint;
  }

  static String _loadAltServiceEndpoint(
      ALT_SERVICE_ENDPOINTS serviceEndpointType) {
    return SmeupConfigurationService.getLocalStorage()
        .getString('$serviceEndpointType'.split('.').last);
  }

  static void saveAltServiceEndpoint(
      ALT_SERVICE_ENDPOINTS serviceEndpointType, String value) {
    SmeupConfigurationService.getLocalStorage()
        .setString('$serviceEndpointType'.split('.').last, value);
  }

  static void resetAltServiceEndpoint() {
    SmeupConfigurationService.getLocalStorage()
        .remove('$ALT_SERVICE_ENDPOINTS.DEFAULT'.split('.').last);
    SmeupConfigurationService.getLocalStorage()
        .remove('$ALT_SERVICE_ENDPOINTS.HTTP'.split('.').last);
  }

  static setLocalStorage() async {
    try {
      // ignore: invalid_use_of_visible_for_testing_member
      SharedPreferences.setMockInitialValues(
          <String, dynamic>{'DEFAULT': '', 'HTTP': ''});
      _localStorge = await SharedPreferences.getInstance();
    } catch (e) {
      SmeupLogService.writeDebugMessage('setLocalStorage failed: $e');
    }
  }

  static SharedPreferences getLocalStorage() {
    return _localStorge;
  }
}
