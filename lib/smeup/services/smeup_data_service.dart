import 'package:dio/dio.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_http_data_service.dart';
import 'package:ken/smeup/services/smeup_image_data_service.dart';
import 'package:ken/smeup/services/smeup_json_data_service.dart';
import 'package:ken/smeup/services/smeup_default_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_message_data_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';

import '../models/fun.dart';

class SmeupDataService {
  static var services = Map<String, SmeupDataServiceInterface>();
  static const DEFAULD_TIMEOUT = 10;
  static int timeout = DEFAULD_TIMEOUT;
  static int _activeDataFetch = 0;

  static initInternalService() {
    SmeupDataService.services['*JSN'] = SmeupJsonDataService();
    SmeupDataService.services['*MSG'] = SmeupMessageDataService();
    SmeupDataService.services['*IMAGE'] = SmeupImageDataService();
    SmeupDataService.services['*HTTP'] = SmeupHttpDataService();
  }

  static Future<SmeupServiceResponse> invoke(Fun? smeupFun,
      {String? httpServiceMethod,
      String? httpServiceUrl,
      dynamic httpServiceBody,
      String? httpServiceContentType,
      dynamic headers}) async {
    SmeupDataServiceInterface? smeupDataService =
        SmeupDataService.getServiceImplementation(
            smeupFun == null ? null : smeupFun.identifier.service);

    if (smeupFun != null) {
      smeupFun.replaceVariables();
    }

    // Read response from service

    SmeupServiceResponse response;

    if (smeupDataService is SmeupDefaultDataService)
      response = await smeupDataService.invoke(smeupFun!);
    else if (smeupDataService is SmeupHttpDataService)
      response = await smeupDataService.invoke(smeupFun,
          httpServiceMethod: httpServiceMethod,
          httpServiceUrl: httpServiceUrl,
          httpServiceBody: httpServiceBody,
          httpServiceContentType: httpServiceContentType,
          headers: headers);
    else
      response = await smeupDataService!.invoke(smeupFun!);

    return response;
  }

  static SmeupDataServiceInterface? getServiceImplementation(String? name) {
    if (name == null || services[name] == null) {
      SmeupLogService.writeDebugMessage(
          ' The server implementation \'${name ?? ''}\' does not exist, will be used SmeupDefaultDataService',
          logType: LogType.warning);
      return services['*DEFAULT'];
    } else {
      return services[name];
    }
  }

  static bool isValid(int statusCode) {
    if (statusCode >= 200 && statusCode < 300)
      return true;
    else
      return false;
  }

  static void writeResponseError(dynamic e, String method) {
    SmeupLogService.writeDebugMessage(
        '*** http response \'$method\' ERROR: ${e.toString()}',
        logType: LogType.error);
  }

  static void writeResponseResult(Response? response, String method) {
    LogType logType =
        response != null && SmeupDataService.isValid(response.statusCode!)
            ? LogType.info
            : LogType.error;

    SmeupLogService.writeDebugMessage(
        '*** http response \'$method\': ${response?.data}',
        logType: logType);
  }

  static dynamic getEmptyDataStructure() {
    return {"messages": [], "columns": null, "rows": null, "type": ""};
  }

  static bool isDataStructure(dynamic data) {
    if (data == null) return false;
    if (data is List) return false;
    if (data['rows'] == null) {
      return false;
    }
    return true;
  }

  static void incrementDataFetch(String? id) {
    _activeDataFetch += 1;
  }

  static void decrementDataFetch(String? id) {
    if (_activeDataFetch == 0) return;
    _activeDataFetch -= 1;
  }

  static int getDataFetch() {
    return _activeDataFetch;
  }

  static void setDataFetch(int value) {
    _activeDataFetch = value;
  }

  static void printRequestDuration(DateTime start) {
    if (SmeupConfigurationService.logLevel == LogType.debug) {
      DateTime end = DateTime.now();
      final diff = end.difference(start);
      SmeupLogService.writeDebugMessage(
          '_invoke dio DURATION: ${diff.inMilliseconds}ms',
          logType: LogType.info);
    }
  }
}
