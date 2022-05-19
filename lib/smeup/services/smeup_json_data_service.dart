import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_utilities.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../models/fun.dart';
import 'smeup_firestore_shared.dart';

class SmeupJsonDataService extends SmeupDataServiceInterface {
  FirebaseFirestore? firestoreInstance;

  SmeupJsonDataService(
      {SmeupDataTransformerInterface? transformer, this.firestoreInstance})
      : super(transformer);

  @override
  Future<SmeupServiceResponse> invoke(smeupFun) async {
    switch (smeupFun.identifier.component) {
      case 'EXD':
        try {
          Map<String, dynamic>? data;

          String? fileName = smeupFun.getObjectByName('obj2').k;

          List<Map<String, dynamic>> list = smeupFun.server;

          final sourceMap =
              list.firstWhereOrNull((element) => element['key'] == 'source');
          String? source = sourceMap != null ? sourceMap['value'] : '';

          String jsonString = '';

          if (source == 'firestore') {
            jsonString = await getFromFirestore(smeupFun, fileName);
          } else if (source!.isNotEmpty) {
            jsonString = await getFromCustomPath(source, fileName);
          } else {
            jsonString = await getFromDefaultFolder(source, fileName);
          }

          // replace placeholders
          jsonString = SmeupUtilities.replaceDictionaryPlaceHolders(jsonString);

          // decode
          data = jsonDecode(jsonString);

          // return the response
          var response = Response(
              data: data,
              statusCode: HttpStatus.accepted,
              requestOptions: RequestOptions(path: ''));

          SmeupDataService.writeResponseResult(
              response, 'SmeupJsonDataService');

          return SmeupServiceResponse(
              true,
              Response(
                  data: data,
                  statusCode: HttpStatus.accepted,
                  requestOptions: RequestOptions(path: '')));
        } catch (e) {
          SmeupLogService.writeDebugMessage('Error in JsonDataService: $e',
              logType: LogType.error);

          return SmeupServiceResponse(
              false,
              Response(
                  data: 'Error in SmeupJsonDataService: ${e.toString()}',
                  statusCode: HttpStatus.badRequest,
                  requestOptions: RequestOptions(path: '')));
        }

      default:
        return SmeupServiceResponse(
            false,
            Response(
                data:
                    'Error in SmeupJsonDataService: component ${smeupFun.identifier.component} not implemented',
                statusCode: HttpStatus.badRequest,
                requestOptions: RequestOptions(path: '')));
    }
  }

  Future<String> getFromFirestore(Fun smeupFun, fileName) async {
    if (firestoreInstance == null)
      throw Exception('Firebase instance not valid');

    List<Map<String, dynamic>> list = smeupFun.server;

    final options = GetOptions(source: await SmeupFirestoreShared.getSource());

    final sch = list.firstWhereOrNull((element) => element['key'] == 'Sch');

    if (sch == null) {
      final msg = 'The Sch is empty';
      SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
      throw Exception(msg);
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestoreInstance!
        .collection(sch['value'])
        .where('formId', isEqualTo: fileName)
        .get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer()!.transform(smeupFun, snapshot);
    } else {
      final msg = 'No transformer defined in the service';
      SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
      throw Exception(msg);
    }

    SmeupLogService.writeDebugMessage(
        '*** \'SmeupJsonDataService\' getFromFirestore. collection: ${sch['value']}; form: $fileName');

    return jsonEncode(responseData);
  }

  Future<String> getFromCustomPath(source, fileName) async {
    String jsonFilePath = '$source/$fileName.json';

    String jsonString = await rootBundle.loadString(jsonFilePath);

    SmeupLogService.writeDebugMessage(
        '*** \'SmeupJsonDataService\' getFromCustomPath: $jsonFilePath');

    return jsonString;
  }

  Future<String> getFromDefaultFolder(source, fileName) async {
    String jsonFilePath =
        '${SmeupConfigurationService.jsonsPath}/forms/$fileName.json';

    String jsonString = await rootBundle.loadString(jsonFilePath);

    SmeupLogService.writeDebugMessage(
        '*** \'SmeupJsonDataService\' getFromDefaultFolder: $jsonFilePath');

    return jsonString;
  }
}
