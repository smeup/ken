import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:mobile_components_library/smeup/services/smeup_dynamism_service.dart';

class SmeupOptions {
  static const double STATIC_BUTTON_ROUNDNESS = 0.0;
  static bool isDebug = false;
  static bool isLoginEnabled = false;
  static bool isOfflineEnabled = false;
  static bool isCacheEnabled = false;
  static bool isLogEnabled = false;
  static bool isLandscapeEnabled = true;
  static bool isVariablesChangingLogEnabled = false;
  static String appDescription = '';
  static Color appSplashColor = Color.fromRGBO(6, 138, 156, 1);
  static Color loaderColor = Colors.blue;
  static ThemeData theme;
  static String jsonsPath;
  static String imagesPath;
  static bool showLoader = false;
  static String defaultServiceToken = '';
  static String defaultServiceUserName;
  static String defaultServicePassword;
  static String defaultServiceEndpoint;
  static String httpServiceEndpoint;
  static Function logoutFunction;
  static PackageInfo _packageInfo;
  static double deviceHeight;
  static double deviceWidth;
  static Orientation orientation;

  static void setPackageInfo(PackageInfo packageInfo) {
    _packageInfo = packageInfo;
    SmeupDynamismService.variables['*VERSION'] =
        _packageInfo != null ? _packageInfo.version : '';
  }

  static PackageInfo getPackageInfo() {
    return _packageInfo;
  }
}
