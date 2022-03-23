import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

class SmeupFirestoreDataService extends SmeupDataServiceInterface {
  FirebaseFirestore fsDatabase;
  final String FIRESTORE_FIELDS = 'firestoreFields';

  SmeupFirestoreDataService(this.fsDatabase,
      {SmeupDataTransformerInterface transformer})
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
      case "GET.DOCUMENT.DEFAULT":
        return await getDocumentDefault(fun);
      case "UPDATE.DOCUMENT":
        return await updateDocument(fun);
      case "DELETE.DOCUMENT":
        return await deleteDocument(fun);
      case "WRITE.DOCUMENT":
        return await writeDocument(fun);
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
            'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
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
          'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
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

      if (id == null) {
        throw Exception('The id is empty. FUN: $smeupFun');
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
            'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      List<String> firestoreFields = _getFireStoreFieldsVariable(smeupFun);

      (responseData['rows'] as List<dynamic>).forEach((dynamic row) {
        row.keys.forEach((key) {
          _addFirestoFieldToList(key, row[key], smeupFun, firestoreFields);
        });
      });

      SmeupVariablesService.setVariable(FIRESTORE_FIELDS, firestoreFields,
          formKey: smeupFun.formKey);

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getDocumentDefault(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final options = GetOptions(source: await getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final fieldId = list.firstWhere((element) => element['key'] == 'fieldId',
          orElse: () => null);

      final key = smeupFun.fun['fun']['parentFun'];

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (fieldId == null) {
        throw Exception('The fieldId is empty. FUN: $smeupFun');
      }

      if (key == null) {
        throw Exception('The key is empty. FUN: $smeupFun');
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          .where('key', isEqualTo: key)
          .where('fieldId', isEqualTo: fieldId['value'])
          .get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (snapshot != null && getTransformer() is NullTransformer == false) {
        responseData = getTransformer().transform(smeupFun, snapshot);
      } else {
        final message =
            'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      List<String> firestoreFields = _getFireStoreFieldsVariable(smeupFun);

      _addFirestoFieldToList(fieldId['value'], responseData['rows'][0][key],
          smeupFun, firestoreFields);

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
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
            'SmeupFirestoreDataService.getForm: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      responseData = _updateFirestoreData(smeupFun, responseData);

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getForm: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> updateDocument(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final id = list.firstWhere((element) => element['key'] == 'id',
          orElse: () => null);

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (id == null) {
        throw Exception('The id is empty. FUN: $smeupFun');
      }

      final checkResult = _checkDocument(smeupFun);

      if (checkResult.isNotEmpty) {
        final messages = {
          "messages": [
            {
              "gravity": LogType.error,
              "message": checkResult,
            }
          ]
        };
        return SmeupServiceResponse(
            false,
            Response(
                data: messages,
                statusCode: HttpStatus.badRequest,
                requestOptions: null));
      }

      List<String> firestoreFields = SmeupVariablesService.getVariable(
              FIRESTORE_FIELDS,
              formKey: smeupFun.formKey) ??
          List<String>.empty(growable: true);

      var formInputFields = Map<String, Object>();
      SmeupVariablesService.getVariables(formKey: smeupFun.formKey)
          .entries
          .forEach((element) {
        if (firestoreFields.contains(element.key)) {
          formInputFields[element.key.toString().replaceFirst(
              smeupFun.formKey.hashCode.toString() + '_', '')] = element.value;
        }
      });

      bool isOnLine = await isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(collection['value'])
            .doc(id['value'])
            .update(formInputFields);
      } else {
        fsDatabase
            .collection(collection['value'])
            .doc(id['value'])
            .update(formInputFields);
      }

      final messages = {
        "messages": [
          {
            "gravity": isOnLine ? LogType.info : LogType.warning,
            "message":
                "${SmeupConfigurationService.appDictionary.getLocalString('updateCompletedSuccessfully')} ${isOnLine ? '' : 'offline'}",
          }
        ]
      };
      return SmeupServiceResponse(
          true,
          Response(
              data: messages,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in updateDocument: $e',
          logType: LogType.error);
      final messages = {
        "messages": [
          {
            "gravity": LogType.error,
            "message": SmeupConfigurationService.appDictionary
                .getLocalString('errorWritingInformation'),
          }
        ]
      };
      return SmeupServiceResponse(
          false,
          Response(
              data: messages,
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }
  }

  Future<SmeupServiceResponse> deleteDocument(SmeupFun smeupFun) async {
    try {
      //String orderId = smeupFun.fun['fun']['obj1']['k'];

      bool isOnLine = await isInternetOn();

      // if (isOnLine) {
      //   QuerySnapshot snapshot = await fsDatabase
      //       .collection(FirestoreSharedService.ordersRowsCollection)
      //       .where('idorder', isEqualTo: orderId)
      //       .get();

      //   snapshot.docs.toList().forEach((orderRowDoc) async {
      //     await fsDatabase
      //         .collection(FirestoreSharedService.ordersRowsCollection)
      //         .doc(orderRowDoc.id)
      //         .delete();
      //   });

      //   await fsDatabase
      //       .collection(FirestoreSharedService.ordersCollection)
      //       .doc(orderId)
      //       .delete();
      // } else {
      //   fsDatabase
      //       .collection(FirestoreSharedService.ordersRowsCollection)
      //       .where('idorder', isEqualTo: orderId)
      //       .get()
      //       .then((QuerySnapshot snapshot) {
      //     snapshot.docs.toList().forEach((orderRowDoc) async {
      //       fsDatabase
      //           .collection(FirestoreSharedService.ordersRowsCollection)
      //           .doc(orderRowDoc.id)
      //           .delete();
      //     });
      //   });

      //   fsDatabase
      //       .collection(FirestoreSharedService.ordersCollection)
      //       .doc(orderId)
      //       .delete();
      // }

      // SmeupVariablesService.setVariable('orderId', '',
      //     formKey: smeupFun.formKey);

      final messages = {
        "messages": [
          {
            "gravity": isOnLine ? LogType.info : LogType.warning,
            "message":
                "${SmeupConfigurationService.appDictionary.getLocalString('updateCompletedSuccessfully')} ${isOnLine ? '' : 'offline'}",
            "smeupObject": {"tipo": "", "parametro": "", "codice": ""}
          }
        ]
      };
      return SmeupServiceResponse(
          true,
          Response(
              data: messages,
              statusCode: HttpStatus.accepted,
              requestOptions: null));
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in deleteDocument: $e',
          logType: LogType.error);
      return SmeupServiceResponse(
          false,
          Response(
              data: null,
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }
  }

  Future<SmeupServiceResponse> writeDocument(SmeupFun smeupFun) async {
    List<Map<String, dynamic>> list = smeupFun.getParameters();

    final collection = list.firstWhere(
        (element) => element['key'] == 'collection',
        orElse: () => null);

    if (collection == null) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    final checkResult = _checkDocument(smeupFun);
    if (checkResult.isNotEmpty) {
      final messages = {
        "messages": [
          {
            "gravity": LogType.error,
            "message": checkResult,
          }
        ]
      };
      return SmeupServiceResponse(
          false,
          Response(
              data: messages,
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }

    try {
      List<String> firestoreFields = _getFireStoreFieldsVariable(smeupFun);

      var formInputFields = Map<String, Object>();
      SmeupVariablesService.getVariables(formKey: smeupFun.formKey)
          .entries
          .forEach((element) {
        if (firestoreFields.contains(element.key)) {
          formInputFields[element.key.toString().replaceFirst(
              smeupFun.formKey.hashCode.toString() + '_', '')] = element.value;
        }
      });

      bool isOnLine = await isInternetOn();

      if (isOnLine) {
        final docRef = await fsDatabase
            .collection(collection['value'])
            .add(formInputFields);

        if (docRef != null) {
          SmeupVariablesService.setVariable(
              'id', await docRef.get().then((snapshot) => snapshot.id),
              formKey: smeupFun.formKey);

          final messages = {
            "messages": [
              {
                "gravity": LogType.info,
                "message": SmeupConfigurationService.appDictionary
                    .getLocalString('updateCompletedSuccessfully'),
              }
            ]
          };
          return SmeupServiceResponse(
              true,
              Response(
                  data: messages,
                  statusCode: HttpStatus.accepted,
                  requestOptions: null));
        } else {
          final messages = {
            "messages": [
              {
                "gravity": LogType.error,
                "message": SmeupConfigurationService.appDictionary
                    .getLocalString('errorWritingInformation'),
              }
            ]
          };
          return SmeupServiceResponse(
              false,
              Response(
                  data: messages,
                  statusCode: HttpStatus.accepted,
                  requestOptions: null));
        }
      } else {
        fsDatabase.collection(collection['value']).add(formInputFields);
        final messages = {
          "messages": [
            {
              "gravity": LogType.warning,
              "message": SmeupConfigurationService.appDictionary
                  .getLocalString('updateSuccessfullyOffline'),
            }
          ]
        };
        return SmeupServiceResponse(
            true,
            Response(
                data: messages,
                statusCode: HttpStatus.accepted,
                requestOptions: null));
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in writeDocument: $e',
          logType: LogType.error);
      final messages = {
        "messages": [
          {
            "gravity": LogType.error,
            "message": SmeupConfigurationService.appDictionary
                .getLocalString('errorWritingInformation'),
          }
        ]
      };
      return SmeupServiceResponse(
          false,
          Response(
              data: messages,
              statusCode: HttpStatus.badRequest,
              requestOptions: null));
    }
  }

  String _checkDocument(SmeupFun smeupFun) {
    return '';
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

  dynamic _updateFirestoreData(SmeupFun smeupFun, dynamic data) {
    try {
      for (var section in data['sections']) {
        _updateFirestoreSection(section, smeupFun);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getInputFields: $e',
          logType: LogType.error);
    }
    return data;
  }

  _updateFirestoreSection(dynamic section, SmeupFun smeupFun) {
    if (section['components'] != null) {
      for (var component in section['components']) {
        if (component['type'] == 'FLD') {
          component['fun'] =
              component['fun'] + ' parentFun(${smeupFun.fun.toString()})';
        }
      }
    }

    if (section['sections'] != null) {
      for (var subSection in section['sections']) {
        _updateFirestoreSection(subSection, smeupFun);
      }
    }
  }

  _getFireStoreFieldsVariable(SmeupFun smeupFun) {
    List<String> firestoreFields = SmeupVariablesService.getVariable(
        FIRESTORE_FIELDS,
        formKey: smeupFun.formKey);
    if (firestoreFields == null) {
      SmeupVariablesService.setVariable(
          FIRESTORE_FIELDS, List<String>.empty(growable: true),
          formKey: smeupFun.formKey);
      firestoreFields = SmeupVariablesService.getVariable(FIRESTORE_FIELDS,
          formKey: smeupFun.formKey);
    }

    return firestoreFields;
  }

  _addFirestoFieldToList(String componentId, dynamic componentValue,
      SmeupFun smeupFun, List<String> firestoreFields) {
    SmeupVariablesService.setVariable(componentId, componentValue,
        formKey: smeupFun.formKey);
    String firestoreKey =
        smeupFun.formKey.hashCode.toString() + '_' + componentId;
    if (!firestoreFields.contains(firestoreKey))
      firestoreFields.add(firestoreKey);
  }
}
