import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';
import 'package:ken/smeup/models/authentication_model.dart';
import 'package:ken/smeup/services/smeup_cache_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:package_info/package_info.dart';
import 'package:ken/smeup/services/SmeupLocalizationService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/external_configuration_model.dart';

enum ALT_SERVICE_ENDPOINTS { DEFAULT, HTTP }

class SmeupConfigurationService {
  static const double STATIC_BUTTON_ROUNDNESS = 0.0;

  static SharedPreferences _localStorge;
  static ThemeData _theme;
  static String _defaultServiceEndpoint;
  static String _httpServiceEndpoint;
  static PackageInfo _packageInfo;
  static Map<DateTime, List> _holidays;

  static LogType logLevel;
  static bool isLoginEnabled = false;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static String jsonsPath;
  static String imagesPath;
  static dynamic appDictionary;
  static ExternalConfigurationModel _appConfiguration;
  static String appBarImage;
  static AuthenticationModel authenticationModel;

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
      AuthenticationModel authenticationModel,
      String appBarImage = ''}) async {
    SmeupConfigurationService.jsonsPath = 'assets/jsons';
    SmeupConfigurationService.imagesPath = 'assets/images';

    await SmeupConfigurationService.setAppConfiguration();

    SmeupConfigurationService.logLevel = logLevel;
    SmeupConfigurationService.appBarImage = appBarImage;

    await SmeupConfigurationService.setLocalStorage();

    await SmeupConfigurationService.setTheme(
        SmeupConfigurationService.getAppConfiguration()?.theme);

    SmeupConfigurationService.appDictionary = localizationService;

    SmeupConfigurationService.setDefaultServiceEndpoint();
    SmeupConfigurationService.setHttpServiceEndpoint();

    SmeupDataService.initInternalService();

    if (customDataServices != null) {
      customDataServices.entries.forEach((customService) {
        SmeupDataService.services[customService.key] = customService.value;
      });
    }

    if (SmeupConfigurationService.isLogEnabled)
      await SmeupLogService.setLogFile();

    SmeupConfigurationService.authenticationModel =
        authenticationModel ?? AuthenticationModel();

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
      SmeupLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: LogType.error);
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
        _theme = ThemeDecoder.decodeThemeData(themeJson, validate: true);
        SmeupLogService.writeDebugMessage('Loaded $themeFile theme file');
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getAppStructure: $e',
          logType: LogType.error);
    } finally {
      if (_theme == null) {
        String themeStr = await rootBundle
            .loadString('packages/ken/assets/jsons/themes/smeup_theme.json');
        dynamic themeJson = json.decode(themeStr);
        _theme = ThemeDecoder.decodeThemeData(themeJson);
        // print(_theme);
      }
    }
  }

  static ThemeData getTheme() {
    return SmeupConfigurationService._theme;
  }

  static setAppConfiguration() async {
    try {
      String jsonString =
          await rootBundle.loadString('assets/jsons/config.json');
      _appConfiguration =
          ExternalConfigurationModel.fromMap(jsonDecode(jsonString));
      SmeupLogService.writeDebugMessage('Loaded config.json');
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getAppConfig: $e',
          logType: LogType.error);
    }
  }

  static ExternalConfigurationModel getAppConfiguration() {
    return _appConfiguration;
  }

  static setDefaultServiceEndpoint() {
    // Load service endpoints from shared preferences
    final savedDefaultServiceEndpoint =
        _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.DEFAULT);

    if (savedDefaultServiceEndpoint != null &&
        savedDefaultServiceEndpoint.isNotEmpty)
      _defaultServiceEndpoint = savedDefaultServiceEndpoint;
    else
      _defaultServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
              ?.defaultServiceEndpoint ??
          '';
  }

  static getDefaultServiceEndpoint() {
    return _defaultServiceEndpoint;
  }

  static setHttpServiceEndpoint() {
    final savedHttpServiceEndpoint =
        _loadAltServiceEndpoint(ALT_SERVICE_ENDPOINTS.HTTP);

    if (savedHttpServiceEndpoint != null && savedHttpServiceEndpoint.isNotEmpty)
      _httpServiceEndpoint = savedHttpServiceEndpoint;
    else
      _httpServiceEndpoint = SmeupConfigurationService.getAppConfiguration()
              ?.httpServiceEndpoint ??
          '';
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
      // SharedPreferences.setMockInitialValues(
      //     <String, dynamic>{'DEFAULT': '', 'HTTP': ''});
      _localStorge = await SharedPreferences.getInstance();
      //_localStorge.setString('DEFAULT', '');
      //_localStorge.setString('HTTP', '');
    } catch (e) {
      SmeupLogService.writeDebugMessage('setLocalStorage failed: $e');
    }
  }

  static SharedPreferences getLocalStorage() {
    return _localStorge;
  }
}
