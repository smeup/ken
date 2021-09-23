import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

typedef bool UntilPredicate(dynamic data);

class SmeupDataServicePoller {
  final Duration interval;
  final String fun;
  final bool ignoreErrors;
  bool _canceled = false;
  GlobalKey<FormState> formKey;

  SmeupDataServicePoller(
    this.formKey, {
    @required this.interval,
    @required this.fun,
    this.ignoreErrors = true,
  });

  Future<dynamic> doPoll({@required UntilPredicate until}) async {
    SmeupFun smeupFun = SmeupFun(fun, formKey);
    while (!_canceled) {
      await Future.delayed(interval);
      if (!_canceled) {
        final smeupServiceResponse = await SmeupDataService.invoke(smeupFun);
        if (!smeupServiceResponse.succeded) {
          if (ignoreErrors) {
            SmeupLogService.writeDebugMessage(
                "Received error: ${smeupServiceResponse.result} - Try to retry",
                logType: LogType.error);
          } else {
            throw Exception(smeupServiceResponse.result);
          }
        } else {
          var pollerData = smeupServiceResponse.result.data;
          if (until(pollerData)) {
            _canceled = true;
            return Future.value(pollerData);
          }
        }
      }
    }
  }

  void cancel() {
    _canceled = true;
  }
}
