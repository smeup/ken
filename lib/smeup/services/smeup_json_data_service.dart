import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';

class SmeupJsonDataService extends SmeupDataServiceInterface {
  Map<String, Map<String, dynamic>> jsons = Map();

  SmeupJsonDataService() : super(NullTransformer());

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
            String customFolder = smeupFun.fun['fun']['obj1']['k'];
            String fileName = smeupFun.fun['fun']['obj2']['k'];

            String jsonFilePath = customFolder.isEmpty
                ? '${SmeupConfigurationService.jsonsPath}/forms/$fileName.json'
                : '$customFolder/$fileName.json';

            SmeupLogService.writeDebugMessage(
                '*** http request \'SmeupJsonDataService\': $jsonFilePath');

            String jsonString = await rootBundle.loadString(jsonFilePath);

            jsonString =
                SmeupUtilities.replaceDictionaryPlaceHolders(jsonString);

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
