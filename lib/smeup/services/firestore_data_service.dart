import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

class SmeupFirestoreDataService extends SmeupDataServiceInterface {
  FirebaseFirestore fsDatabase;

  SmeupFirestoreDataService(
      SmeupDataTransformerInterface transformer, this.fsDatabase)
      : super(transformer) {
    fsDatabase.settings = const Settings(persistenceEnabled: true);
  }

  @override
  Future<SmeupServiceResponse> invoke(SmeupFun fun) async {
    switch (fun.fun['fun']['function']) {
      case "GET.DOCUMENTS":
        return await getDocuments(fun);
      case "GET.DOCUMENT":
        return await getDocument(fun);
      case "GET.FORM":
        return await getForm(fun);
      default:
        return null;
    }
  }

  Future<Source> getSource() async {
    final bool onValue = await isInternetOn();
    if (onValue) {
      return Source.server;
    } else {
      return Source.cache;
    }
  }

  Future<bool> isInternetOn() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    switch (connectivityResult) {
      case ConnectivityResult.none:
        return false;
      default:
        return true;
    }
  }
  //

  Future<SmeupServiceResponse> getDocuments(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final options = GetOptions(source: await getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          //.orderBy(orderBy, descending: true)
          .get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (snapshot != null && getTransformer() is NullTransformer == false) {
        responseData = getTransformer().transform(smeupFun, snapshot);
      } else {
        final message =
            'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getDocument(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final options = GetOptions(source: await getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final id = list.firstWhere((element) => element['key'] == 'id',
          orElse: () => null);

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      DocumentSnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          .doc(id['value'])
          .get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (snapshot != null && getTransformer() is NullTransformer == false) {
        responseData = getTransformer().transform(smeupFun, snapshot);
      } else {
        final message =
            'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getForm(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final options = GetOptions(source: await getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final formId = list.firstWhere((element) => element['key'] == 'formId',
          orElse: () => null);

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          .where('formId', isEqualTo: formId['value'])
          .get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (snapshot != null && getTransformer() is NullTransformer == false) {
        responseData = getTransformer().transform(smeupFun, snapshot);
      } else {
        final message =
            'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  SmeupServiceResponse _getErrorResponse(String message) {
    final messages = {
      "messages": [
        {
          "gravity": LogType.error,
          "message": message,
        }
      ]
    };
    SmeupLogService.writeDebugMessage(message, logType: LogType.error);
    return SmeupServiceResponse(
        false,
        Response(
            data: messages,
            statusCode: HttpStatus.badRequest,
            requestOptions: null));
  }
}
