import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

class SmeupMessageDataService extends SmeupDataServiceInterface {
  Map<String, Map<String, dynamic>> jsons = Map();

  SmeupMessageDataService({SmeupDataTransformerInterface transformer})
      : super(transformer);

  @override
  Future<SmeupServiceResponse> invoke(smeupFun) async {
    switch (smeupFun.fun['fun']['component']) {
      case 'FBK':
        try {
          Map<String, dynamic> data = SmeupDataService.getEmptyDataStructure();
          String message = '';

          if (smeupFun.fun['fun']['P'] != null) {
            message = smeupFun.fun['fun']['P'];
          }

          LogType logType = LogType.info;
          String gravity = smeupFun.fun['fun']['obj1']['k'];
          if (gravity.isNotEmpty) {
            switch (gravity) {
              case "info":
                logType = LogType.info;
                break;
              case "debug":
                logType = LogType.debug;
                break;
              case "error":
                logType = LogType.error;
                break;
              case "none":
                logType = LogType.none;
                break;
              case "warning":
                logType = LogType.warning;
                break;
              default:
                logType = LogType.info;
            }
          }

          int milliseconds = 500;
          if (smeupFun.fun['fun']['obj2']['k'] != null) {
            milliseconds =
                int.tryParse(smeupFun.fun['fun']['obj2']['k']) ?? 500;
          }

          data['messages'] = [
            {
              "gravity": logType,
              "message": message,
              "milliseconds": milliseconds
            }
          ];

          var response = Response(
              data: data,
              statusCode: HttpStatus.accepted,
              requestOptions: null);

          SmeupDataService.writeResponseResult(
              response, 'SmeupMessageDataService');

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
                  data: 'Error in SmeupMessageDataService',
                  statusCode: HttpStatus.badRequest,
                  requestOptions: null));
        }

        break;

      default:
        return SmeupServiceResponse(
            false,
            Response(
                data:
                    'Error in SmeupMessageDataService: component ${smeupFun.fun['fun']['component']} not implemented',
                statusCode: HttpStatus.badRequest,
                requestOptions: null));
    }
  }

  static manageResponseMessage(BuildContext context, dynamic response) async {
    try {
      if (response.data['messages'] != null) {
        List messages = response.data['messages'];
        if (messages.length > 0) {
          messages.forEach((message) {
            MessagesPromptMode mode =
                message['mode'] ?? MessagesPromptMode.snackbar;
            LogType severity = message['gravity'] ?? LogType.info;
            String text = message['message'];
            int milliseconds = message['milliseconds'] ?? 500;

            Color backColor;
            switch (severity) {
              case LogType.error:
                backColor = SmeupConfigurationService.getTheme().errorColor;
                break;
              case LogType.warning:
                backColor = Colors.orange;
                break;
              default:
                backColor = SmeupConfigurationService.getTheme()
                    .snackBarTheme
                    .backgroundColor;
            }

            if (text.isNotEmpty) {
              switch (mode) {
                case MessagesPromptMode.snackbar:
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text(text),
                        backgroundColor: backColor,
                        duration: Duration(milliseconds: milliseconds)),
                  );

                  break;
                default:
              }
            }
          });
          await new Future.delayed(const Duration(seconds: 1));
        }
      }
    } catch (e) {}
  }
}
