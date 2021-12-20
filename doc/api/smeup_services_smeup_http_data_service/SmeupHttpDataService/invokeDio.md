


# invokeDio method








[Future](https://api.flutter.dev/flutter/dart-async/Future-class.html)&lt;[Response](https://pub.dev/documentation/dio/4.0.0/dio/Response-class.html)> invokeDio
({[String](https://api.flutter.dev/flutter/dart-core/String-class.html) method, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) url, dynamic body, [String](https://api.flutter.dev/flutter/dart-core/String-class.html) contentType, dynamic headers})








## Implementation

```dart
Future<Response> invokeDio(
    {String method,
    String url,
    dynamic body,
    String contentType,
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







