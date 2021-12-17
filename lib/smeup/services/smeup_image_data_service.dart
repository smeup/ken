import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';

class SmeupImageDataService implements SmeupDataServiceInterface {
  SmeupImageDataService();

  @override
  Future<SmeupServiceResponse> invoke(smeupFun, {BuildContext context}) async {
    try {
      SmeupLogService.writeDebugMessage(
          '*** \'SmeupImageDataService\': ${smeupFun.fun['fun']['obj1']['k']}');

      final imageLocalPath =
          '${SmeupConfigurationService.imagesPath}/${smeupFun.fun['fun']['obj1']['k']}';

      return SmeupServiceResponse(true, {"imageLocalPath": imageLocalPath});
    } catch (e) {
      return SmeupServiceResponse(
          false,
          Response(
              data: 'Error in SmeupImageDataService',
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }
  }
}
