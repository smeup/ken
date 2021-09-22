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
                '${SmeupConfigurationService.jsonsPath}/${smeupFun.fun['fun']['obj2']['k']}.json';

            SmeupLogService.writeDebugMessage(
                '*** http request \'SmeupJsonDataService\': $jsonFilePath');

            String jsonString = await rootBundle.loadString(jsonFilePath);

            if (SmeupConfigurationService.appDictionary != null) {
              String workString = await rootBundle.loadString(jsonFilePath);
              RegExp re = RegExp(r'\{\{.*\}\}');
              re.allMatches(jsonString).forEach((match) {
                final placeHolder =
                    jsonString.substring(match.start, match.end);
                if (placeHolder != null && placeHolder.isNotEmpty) {
                  final dictionaryKey =
                      placeHolder.replaceFirst('{{', '').replaceFirst('}}', '');

                  if (dictionaryKey != null &&
                      SmeupConfigurationService.appDictionary
                              .getLocalString(dictionaryKey) !=
                          null) {
                    workString = workString.replaceAll(
                        placeHolder,
                        SmeupConfigurationService.appDictionary
                            .getLocalString(dictionaryKey));
                  }
                }
              });
              jsonString = workString;
            }

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
