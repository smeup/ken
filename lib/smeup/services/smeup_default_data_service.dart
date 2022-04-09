import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_cache_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../models/fun.dart';

class SmeupDefaultDataService extends SmeupDataServiceInterface {
  late Dio dio;
  String? server;
  static const DEFAULD_TIMEOUT = 10000;

  SmeupDefaultDataService({SmeupDataTransformerInterface? transformer})
      : super(transformer) {
    BaseOptions options = new BaseOptions(
      connectTimeout: DEFAULD_TIMEOUT,
      receiveTimeout: DEFAULD_TIMEOUT,
    );
    dio = Dio(options);
  }

  @override
  Future<SmeupServiceResponse> invoke(SmeupFun smeupFun) async {
    try {
      dynamic data;
      Response? response;
      String url;
      String contentType;

      url = '${SmeupConfigurationService.getDefaultServiceEndpoint()}/jfun';
      contentType = 'application/json';
      data = smeupFun.getJson();

      SmeupLogService.writeDebugMessage(
          '*** http request \'SmeupDefaultDataService\': $data');

      response = await invokeDio(
          url: url,
          body: data,
          method: 'post',
          contentType: contentType,
          cache: 0,
          forceCache: false);

      SmeupDataService.writeResponseResult(response, 'SmeupDefaultDataService');

      bool isValid = SmeupDataService.isValid(response!.statusCode!);

      dynamic responseData;

// Apply transformation to service response (only on success)
      if (isValid && getTransformer() is NullTransformer == false) {
        responseData = getTransformer()!.transform(smeupFun, response.data);
      } else {
        final message =
            'SmeupDefaultDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      return SmeupServiceResponse(
          isValid,
          Response(
              data: responseData,
              statusCode: response.statusCode,
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      final message =
          'SmeupDefaultDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  SmeupServiceResponse _getErrorResponse(String message) {
    final messages = {
      "messages": [
        {
          "gravity": LogType.error,
          "message": message,
        }
      ]
    };
    SmeupLogService.writeDebugMessage(message, logType: LogType.error);
    return SmeupServiceResponse(
        false,
        Response(
            data: messages,
            statusCode: HttpStatus.badRequest,
            requestOptions: RequestOptions(path: '')));
  }

  Future<Response?> invokeDio(
      {String? method,
      String? url,
      dynamic body,
      String? contentType,
      int cache = 0,
      bool forceCache = false}) async {
    DateTime start = DateTime.now();

    try {
      final cacheDuration = Duration(
          days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: cache);

      Response? responseFromCache =
          await _getResposeFromCache(url, body, forceCache);
      if (responseFromCache != null) {
        SmeupDataService.printRequestDuration(start);
        return responseFromCache;
      }

      dio.options.headers.clear();
      dio.options.headers['content-type'] = contentType;

      dio.options.headers['Authorization'] =
          SmeupConfigurationService.getLocalStorage()!
              .getString('authorization');

      late Response response;

      switch (method) {
        case 'post':
          response = await dio.post(url!, data: body);
          break;
        case 'put':
          response = await dio.put(url!, data: body);
          break;
        case 'get':
          response = await dio.get(url!);
          break;
        case 'delete':
          response = await dio.delete(url!);
          break;
      }

      _addResposeToCache(response, url, body, cacheDuration);

      return Future(() {
        SmeupDataService.printRequestDuration(start);
        return response;
      });
    } on DioError catch (e) {
      SmeupLogService.writeDebugMessage('_invoke dio error: $e (${e.message})',
          logType: LogType.error);
      SmeupDataService.printRequestDuration(start);
      if (e.response != null) {
        return e.response;
      } else {
        return Response(
            data: 'Unkwnown Error',
            statusCode: HttpStatus.badRequest,
            requestOptions: RequestOptions(path: ''));
      }
    }
  }

  Future<Response?> _getResposeFromCache(
      String? url, dynamic body, bool forceCache) async {
    if (forceCache) {
      try {
        SmeupLogService.writeDebugMessage(
            'getting the response from the cache ...');
        // we are online but we are forcing to get the response from the cache

        // online is not working. check if the cache element exists in the list
        final cacheElement =
            SmeupCacheService.getElement(SmeupCacheService.getCacheKey(url));

        // if it doesn't exist return error
        if (cacheElement != null) {
          // otherwise I fetch the cache element and return the value
          List<String> list = await _fetch(cacheElement);

          //if (list != null) {
          dynamic result = jsonDecode(list.first);
          SmeupLogService.writeDebugMessage(
              'response returned from the cache ...',
              logType: LogType.warning);
          return Response(
              data: result,
              statusCode: HttpStatus.accepted,
              requestOptions: RequestOptions(path: ''));
          //}
        }
      } catch (e) {
        SmeupLogService.writeDebugMessage(
            'error in getting the response from the cache: $e',
            logType: LogType.error);
      }
    }

    return Future(() {
      return null;
    });
  }

  _fetch(cacheElement) {
    try {
      cacheElement.fetch(() {
        // if the element is expired: remove the cache element from the list and return null
        // return Future(() {
        //   SmeupLogService.writeDebugMessage('no cache found ...');
        //   return null;
        // });
        return Future(() {
          SmeupLogService.writeDebugMessage('no cache found ...');
          return null;
        });
      });
    } catch (e) {}
  }

  void _addResposeToCache(Response<dynamic> response, String? url, dynamic body,
      Duration cacheExpireTime) async {
    if (SmeupDataService.isValid(response.statusCode!) &&
        cacheExpireTime.inSeconds > 0) {
      SmeupLogService.writeDebugMessage('caching the response ....');

      // we are online but I save the cache anyway
      final cacheElement = SmeupCacheService.createElement(cacheExpireTime);

      // fetch the cache element and set the value
      await cacheElement.fetch(() {
        // set the value of the cache element
        return Future(() {
          final list = List<String>.empty(growable: true);
          String result = jsonEncode(response.data);
          list.add(result);
          return list;
        });
      });

      // add the cache element in the list
      SmeupCacheService.addElement(
          SmeupCacheService.getCacheKey(url), cacheElement);

      // return the result from online
      SmeupLogService.writeDebugMessage('response cached');
    }
  }
}
