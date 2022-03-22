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
      case "GET.DEFAULT":
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

      List<String> firestoreFields = SmeupVariablesService.getVariable(
              'firestoreFields',
              formKey: smeupFun.formKey) ??
          List<String>.empty(growable: true);

      (responseData['rows'] as List<dynamic>).forEach((dynamic row) {
        row.keys.forEach((key) {
          SmeupVariablesService.setVariable(key, row[key],
              formKey: smeupFun.formKey);
          String firestoreKey =
              smeupFun.formKey.hashCode.toString() + '_' + key;
          if (!firestoreFields.contains(firestoreKey))
            firestoreFields.add(firestoreKey);
        });
      });

      SmeupVariablesService.setVariable('firestoreFields', firestoreFields,
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

      final formId = list.firstWhere((element) => element['key'] == 'formId',
          orElse: () => null);

      final fieldId = list.firstWhere((element) => element['key'] == 'fieldId',
          orElse: () => null);

      if (collection == null) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (formId == null) {
        throw Exception('The formId is empty. FUN: $smeupFun');
      }

      if (fieldId == null) {
        throw Exception('The fieldId is empty. FUN: $smeupFun');
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          .where('formId', isEqualTo: formId['value'])
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
              'firestoreFields',
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
      SmeupLogService.writeDebugMessage(
          'Errore durante la cancellazione dell\'ordine: $e',
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
      // final df = new DateFormat('dd/MM/yyyy');

      // final order = {
      //   "customer": SmeupUtilities.getInt(SmeupVariablesService.getVariable(
      //       'fldCustomer',
      //       formKey: smeupFun.formKey)),
      //   "address": SmeupUtilities.getInt(SmeupVariablesService.getVariable(
      //       'fldAddress',
      //       formKey: smeupFun.formKey)),
      //   "description": SmeupVariablesService.getVariable('fldDescription',
      //           formKey: smeupFun.formKey)
      //       .toString(),
      //   "date": DateFormat('yyyyMMdd').format(df.parse(
      //       SmeupVariablesService.getVariable('fldDate',
      //           formKey: smeupFun.formKey)))
      // };

      if (await isInternetOn()) {
        // final docRef = await fsDatabase
        //     .collection(FirestoreSharedService.ordersCollection)
        //     .add(order);

        var docRef;

        if (docRef != null) {
          // SmeupVariablesService.setVariable(
          //     'orderId', await docRef.get().then((snapshot) => snapshot.id),
          //     formKey: smeupFun.formKey);

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
        // fsDatabase
        //     .collection(FirestoreSharedService.ordersCollection)
        //     .add(order);
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
      SmeupLogService.writeDebugMessage(
          'Errore durante la scrittura dell\'ordine: $e',
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
}
