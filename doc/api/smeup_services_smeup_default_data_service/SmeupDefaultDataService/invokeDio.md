


# invokeDio method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Response](https://pub.dev/documentation/dio/4.0.0/dio/Response-class.html)> invokeDio
({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) method, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) url, dynamic body, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) contentType, [int](https://api.flutter.dev/flutter/dart-core/int-class.html) cache = 0, [bool](https://api.flutter.dev/flutter/dart-core/bool-class.html) forceCache = false})








## Implementation

```dart
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
        SmeupConfigurationService.getLocalStorage()
            .getString('authorization');

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
```







