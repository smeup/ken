import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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

import '../models/smeup_fun.dart';
import 'firestore_shared.dart';

class SmeupJsonDataService extends SmeupDataServiceInterface {
  FirebaseFirestore firestoreInstance;

  SmeupJsonDataService(
      {SmeupDataTransformerInterface transformer, this.firestoreInstance})
      : super(transformer);

  @override
  Future<SmeupServiceResponse> invoke(smeupFun) async {
    switch (smeupFun.fun['fun']['component']) {
      case 'EXD':
        try {
          Map<String, dynamic> data;

          String fileName = smeupFun.fun['fun']['obj2']['k'];

          //String customFolder = smeupFun.fun['fun']['obj1']['k'];
          List<Map<String, dynamic>> list = smeupFun.getParameters();

          final sourceMap = list.firstWhere(
              (element) => element['key'] == 'source',
              orElse: () => null);
          String source = sourceMap != null ? sourceMap['value'] : '';

          String jsonString = '';

          if (source == 'firestore') {
            jsonString = await getFromFirestore(smeupFun, fileName);
          } else if (source.isNotEmpty) {
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
          SmeupLogService.writeDebugMessage('Error in JsonDataService: $e',
              logType: LogType.error);

          return SmeupServiceResponse(
              false,
              Response(
                  data: 'Error in SmeupJsonDataService: ${e.toString()}',
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

  Future<String> getFromFirestore(SmeupFun smeupFun, fileName) async {
    if (firestoreInstance == null)
      throw Exception('Firebase instance not valid');

    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final options = GetOptions(source: await FirestoreShared.getSource());

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    if (collection == null) {
      final msg = 'The collection is empty';
      SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
      throw Exception(msg);
    }

    QuerySnapshot<Map<String, dynamic>> snapshot = await firestoreInstance
        .collection(collection['value'])
        .where('formId', isEqualTo: fileName)
        .get(options);

    dynamic responseData;

    // Apply transformation to service response (only on success)
    if (snapshot == null) {
      final msg = 'Form not found';
      SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
      throw Exception(msg);
    }

    if (getTransformer() is NullTransformer == false) {
      responseData = getTransformer().transform(smeupFun, snapshot);
    } else {
      final msg = 'No transformer defined in the service';
      SmeupLogService.writeDebugMessage(msg, logType: LogType.error);
      throw Exception(msg);
    }

    responseData = _updateParentFun(smeupFun, responseData);

    SmeupLogService.writeDebugMessage(
        '*** \'SmeupJsonDataService\' getFromFirestore. collection: ${collection['value']}; form: $fileName');

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

  dynamic _updateParentFun(SmeupFun smeupFun, dynamic data) {
    try {
      String parentFun = smeupFun.getSmeupFormatString();

      for (var section in data['sections']) {
        _updateFirestoreSection(section, parentFun);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in JsonDataService.updateParentFun: $e',
          logType: LogType.error);
    }
    return data;
  }

  _updateFirestoreSection(dynamic section, String parentFun) {
    if (section['components'] != null) {
      for (var component in section['components']) {
        if (component['type'] == 'FLD') {
          if (component['fun'].toString().indexOf('SERVER(') < 0) {
            component['fun'] =
                component['fun'] + ' SERVER(parentFun($parentFun))';
          } else {
            // TODO:
            //  - deserialize the fun as SmeupFun(..) from component['fun']
            //  - add the SERVER object
            //  - add the parentfun into the SERVER OBJECT
            //  - serialize the fun back to component['fun']
          }
        }
      }
    }

    if (section['sections'] != null) {
      for (var subSection in section['sections']) {
        _updateFirestoreSection(subSection, parentFun);
      }
    }
  }
}
