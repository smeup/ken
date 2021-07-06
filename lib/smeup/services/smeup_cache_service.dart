import 'package:async/async.dart';
import 'package:mobile_components_library/smeup/models/smeup_cache_model.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupCacheService {
  static const DEFAULD_RETRY = 2; // seconds
  static Map<String, AsyncCache<List<String>>> _cacheList;
  static String cacheUsername;
  static String cachePassword;
  static String cacheserver;
  static String cacheEnvironment;
  static bool cacheLogEnabled;
  static bool cacheIsTest;
  static bool isOnline = true;
  static SmeupCacheModel cacheModel;
  static bool isPinging = false;
  static bool isBusy = false;
  static dynamic fun;

  static init() {
    _cacheList = Map<String, AsyncCache<List<String>>>();
  }

  static reset() {
    SmeupLogService.writeDebugMessage('reset cache');
    cacheModel.isOnline = true;
    isOnline = true;
    SmeupDataService.timeout = 10;
    clearCache();
  }

  static AsyncCache<List<String>> createElement(Duration _offLineExpireTime) {
    return AsyncCache<List<String>>(_offLineExpireTime);
  }

  static removeElement(String key) {
    SmeupLogService.writeDebugMessage('remove cache element: $key');
    _cacheList.remove(key);
  }

  static AsyncCache<List<String>> getElement(String key) {
    if (_cacheList.containsKey(key))
      SmeupLogService.writeDebugMessage('hit cache element: $key');
    return _cacheList[key];
  }

  static addElement(String key, AsyncCache<List<String>> value) {
    if (!_cacheList.containsKey(key))
      SmeupLogService.writeDebugMessage('add cache element: $key');
    _cacheList[key] = value;
  }

  static clearCache() {
    SmeupLogService.writeDebugMessage('clear cache', logType: LogType.warning);
    _cacheList.clear();
  }

  static String getCacheKey(String url) {
    return '$url';
  }
}
