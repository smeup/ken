import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_treeview/tree_view.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_cache_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service_interface.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_service_response.dart';

class SmeupDefaultDataService implements SmeupDataServiceInterface {
  Dio dio;
  String server;
  static const DEFAULD_TIMEOUT = 10000;

  SmeupDefaultDataService() {
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
      Response response;
      String url;
      String contentType;

      url = '${SmeupConfigurationService.getDefaultServiceEndpoint()}/jfun';
      contentType = 'application/json';
      data = smeupFun.fun;

      SmeupLogService.writeDebugMessage(
          '*** http request \'SmeupDefaultDataService\': ${jsonEncode(data)}');

      response = await invokeDio(
          url: url,
          body: data,
          method: 'post',
          contentType: contentType,
          cache: 0,
          forceCache: false);

      SmeupDataService.writeResponseResult(response, 'SmeupDefaultDataService');

      bool isValid = SmeupDataService.isValid(response.statusCode);

      var responseData = _getResponseData(smeupFun, response, isValid);

      return SmeupServiceResponse(
          isValid,
          Response(
              data: responseData,
              statusCode: response.statusCode,
              requestOptions: null));
    } catch (e) {
      return SmeupServiceResponse(
          false,
          Response(
              data: 'Error in SmeupDefaultDataService',
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }
  }

  Future<Response> invokeDio(
      {String method,
      String url,
      dynamic body,
      String contentType,
      int cache = 0,
      bool forceCache = false}) async {
    DateTime start = DateTime.now();

    try {
      final cacheDuration = Duration(
          days: 0, hours: 0, minutes: 0, seconds: 0, milliseconds: cache);

      Response responseFromCache =
          await _getResposeFromCache(url, body, forceCache);
      if (responseFromCache != null) {
        SmeupDataService.printRequestDuration(start);
        return responseFromCache;
      }

      dio.options.headers.clear();
      dio.options.headers['content-type'] = contentType;

      dio.options.headers['Authorization'] =
          '${SmeupConfigurationService.defaultServiceToken}';

      Response response;

      switch (method) {
        case 'post':
          response = await dio.post(url, data: body);
          break;
        case 'put':
          response = await dio.put(url, data: body);
          break;
        case 'get':
          response = await dio.get(url);
          break;
        case 'delete':
          response = await dio.delete(url);
          break;
      }

      _addResposeToCache(response, url, body, cacheDuration);

      return Future(() {
        SmeupDataService.printRequestDuration(start);
        return response;
      });
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          '_invoke dio error: $e (${e.message != null ? e.message : ''})',
          logType: LogType.error);
      SmeupDataService.printRequestDuration(start);
      if (e.response != null) {
        return e.response;
      } else {
        return Response(
            data: 'Unkwnown Error',
            statusCode: HttpStatus.badRequest,
            requestOptions: null);
      }
    }
  }

  Future<Response> _getResposeFromCache(
      String url, dynamic body, bool forceCache) async {
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
          List<String> list = await cacheElement.fetch(() {
            // if the element is expired: remove the cache element from the list and return null
            return Future(() {
              SmeupLogService.writeDebugMessage('no cache found ...');
              return null;
            });
          });

          if (list != null) {
            dynamic result = jsonDecode(list.first);
            SmeupLogService.writeDebugMessage(
                'response returned from the cache ...',
                logType: LogType.warning);
            return Response(
                data: result,
                statusCode: HttpStatus.accepted,
                requestOptions: null);
          }
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

  void _addResposeToCache(Response<dynamic> response, String url, dynamic body,
      Duration cacheExpireTime) async {
    if (SmeupDataService.isValid(response.statusCode) &&
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

  dynamic _getResponseData(
      SmeupFun smeupFun, Response<dynamic> response, bool isValid) {
    switch (smeupFun.fun['fun']['component']) {
      case 'EXD':
        return response.data;

      case 'EXB':
        dynamic res = SmeupDataService.getEmptyDataStructure();

        // columns
        res['columns'] = response.data['columns'];
        // (response.data['columns'] as List)
        //     .map((e) => {
        //           'code': e['code'],
        //           'text': e['text'],
        //           'hidden': e['IO'] == 'H' ? true : false
        //         })
        //     .toList();

        // rows
        List rows = List<dynamic>.empty(growable: true);

        (response.data['rows'] as List).forEach((row) {
          var newRow = Map();
          (res['columns'] as List).forEach((column) {
            final value =
                row['fields'][column['code']]['smeupObject']['codice'];
            newRow[column['code']] = value;
            newRow['tipo'] =
                row['fields'][column['code']]['smeupObject']['tipo'];
            newRow['parametro'] =
                row['fields'][column['code']]['smeupObject']['parametro'];
            newRow['codice'] =
                row['fields'][column['code']]['smeupObject']['codice'];
          });
          rows.add(newRow);
        });

        res['rows'] = rows;
        res['type'] = 'SmeupTable';
        return res;

      case 'TRE':
        dynamic res = SmeupDataService.getEmptyDataStructure();
        List<Node> rows = List<Node>.empty(growable: true);
        (response.data['children'] as List).forEach((child) {
          var newRow = Node(
              children: _loadTreeChildren(child['children']),
              icon: IconData(59251, fontFamily: 'MaterialIcons'),
              data: child['content'],
              key: child['content']['codice'],
              label: child['content']['testo']);
          rows.add(newRow);
        });
        res['rows'] = rows;
        res['type'] = 'SmeupTreeNode';
        return res;
      case 'FBK':
        break;

      default:
        return response.data;
    }
  }

  List<Node> _loadTreeChildren(parent) {
    List<Node> rows = List<Node>.empty(growable: true);
    (parent as List).forEach((child) {
      var newRow = Node(
          children: _loadTreeChildren(child),
          key: child['content']['codice'],
          label: child['content']['testo']);
      rows.add(newRow);
    });
    return rows;
  }
}
