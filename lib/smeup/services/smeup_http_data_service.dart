import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

class SmeupHttpDataService extends SmeupDataServiceInterface {
  late Dio dio;
  String? server;
  static const DEFAULD_TIMEOUT = 5000;

  SmeupHttpDataService({SmeupDataTransformerInterface? transformer})
      : super(transformer) {
    BaseOptions options = new BaseOptions(
      connectTimeout: DEFAULD_TIMEOUT,
      receiveTimeout: DEFAULD_TIMEOUT,
    );
    dio = Dio(options);
  }

  @override
  Future<SmeupServiceResponse> invoke(SmeupFun? smeupFun,
      {String? httpServiceMethod,
      String? httpServiceUrl,
      dynamic httpServiceBody,
      String? httpServiceContentType,
      dynamic headers}) async {
    try {
      dynamic data;
      Response? response;

      SmeupLogService.writeDebugMessage(
          '*** http request \'SmeupHttpDataService\': ${jsonEncode(data)}');

      response = await invokeDio(
          url: httpServiceUrl,
          body: httpServiceBody,
          method: httpServiceMethod,
          contentType: httpServiceContentType,
          headers: headers);

      SmeupDataService.writeResponseResult(response, 'SmeupHttpDataService');

      bool isValid = SmeupDataService.isValid(response!.statusCode!);

      return SmeupServiceResponse(
          isValid,
          Response(
              data: response,
              statusCode: response.statusCode,
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      return SmeupServiceResponse(
          false,
          Response(
              data: 'Error in SmeupHttpDataService',
              statusCode: HttpStatus.badRequest,
              requestOptions: RequestOptions(path: '')));
    }
  }

  Future<Response?> invokeDio(
      {String? method,
      String? url,
      dynamic body,
      String? contentType,
      dynamic headers}) async {
    DateTime start = DateTime.now();

    try {
      dio.options.headers.clear();
      dio.options.headers['content-type'] = contentType;

      // dio.options.headers['Authorization'] =
      //     '${SmeupOptions.defaultServiceToken}';
      if (headers != null && headers is Map) {
        headers.entries.forEach((header) {
          dio.options.headers[header.key] = header.value;
        });
      }

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
}
