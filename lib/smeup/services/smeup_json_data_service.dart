import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service_interface.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_service_response.dart';

class SmeupJsonDataService implements SmeupDataServiceInterface {
  Map<String, Map<String, dynamic>> jsons = Map();

  SmeupJsonDataService(List<String> preloadedJsons) {
    if (preloadedJsons != null) {
      preloadedJsons.forEach((jsonFile) {
        String jsonFilePath = '${SmeupOptions.jsonsPath}/$jsonFile.json';
        rootBundle.loadString(jsonFilePath).then((jsonString) {
          Map<String, dynamic> data = jsonDecode(jsonString);
          jsons[jsonFile] = data;
        });
      });
    }
  }

  @override
  Future<SmeupServiceResponse> invoke(smeupFun) async {
    switch (smeupFun.fun['fun']['component']) {
      case 'EXD':
        try {
          Map<String, dynamic> data;

          if (jsons != null &&
              jsons.keys.contains(smeupFun.fun['fun']['obj2']['k'])) {
            data = jsons[smeupFun.fun['fun']['obj2']['k']];
          } else {
            String jsonFilePath =
                '${SmeupOptions.jsonsPath}/${smeupFun.fun['fun']['obj2']['k']}.json';

            SmeupLogService.writeDebugMessage(
                '*** http request \'SmeupJsonDataService\': $jsonFilePath');

            String jsonString = await rootBundle.loadString(jsonFilePath);
            data = jsonDecode(jsonString);
          }

          var response = Response(
              data: data,
              statusCode: HttpStatus.accepted,
              requestOptions: null);

          SmeupDataService.writeResponseResult(
              response, 'SmeupJsonDataService');

          return SmeupServiceResponse(
              true,
              Response(
                  data: data,
                  statusCode: HttpStatus.accepted,
                  requestOptions: null));
        } catch (e) {
          return SmeupServiceResponse(
              false,
              Response(
                  data: 'Error in SmeupJsonDataService',
                  statusCode: HttpStatus.badRequest,
                  requestOptions: null));
        }

        break;

      default:
        return SmeupServiceResponse(
            false,
            Response(
                data:
                    'Error in SmeupJsonDataService: component ${smeupFun.fun['fun']['component']} not implemented',
                statusCode: HttpStatus.badRequest,
                requestOptions: null));
    }
  }
}
