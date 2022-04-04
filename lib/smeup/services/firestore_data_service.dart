import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import 'firestore_shared.dart';

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

  Future<SmeupServiceResponse> getDocuments(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final options = GetOptions(source: await FirestoreShared.getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final filters = list.firstWhere((element) => element['key'] == 'filters',
          orElse: () => null);

      final sort = list.firstWhere((element) => element['key'] == 'sort',
          orElse: () => null);

      if (collection == null || collection.toString().isEmpty) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      Query<Map<String, dynamic>> query =
          fsDatabase.collection(collection['value']);

      if (filters != null && filters.toString().isNotEmpty) {
        var parmsSplit = SmeupFun.splitParameters(filters['value']);
        parmsSplit.forEach((element) {
          Map ds = SmeupFun.deserilizeParameter(element);
          final key = ds['key'];
          var value = ds['value'];
          query = query.where(key, isEqualTo: value);
        });
      }

      if (sort != null && sort.toString().isNotEmpty) {
        var parmsSplit = SmeupFun.splitParameters(sort['value']);
        parmsSplit.forEach((element) {
          Map ds = SmeupFun.deserilizeParameter(element);
          final key = ds['key'];
          var descending = ds['value'] == 'descending';
          query = query.orderBy(key, descending: descending);
        });
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

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

      final options = GetOptions(source: await FirestoreShared.getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final id = list.firstWhere((element) => element['key'] == 'id',
          orElse: () => null);

      if (collection == null || collection.toString().isEmpty) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (id == null || id.toString().isEmpty) {
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

      final options = GetOptions(source: await FirestoreShared.getSource());

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final fieldId = list.firstWhere((element) => element['key'] == 'fieldId',
          orElse: () => null);

      if (collection == null || collection.toString().isEmpty) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (fieldId == null || fieldId.toString().isEmpty) {
        throw Exception('The fieldId is empty. FUN: $smeupFun');
      }

      final server = smeupFun.fun['fun']['SERVER'];
      final key = SmeupFun.extractArg(server, 'parentFun');

      if (key == null || key.toString().isEmpty) {
        throw Exception('The key is empty. FUN: $smeupFun');
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection['value'])
          .where('key', isEqualTo: key)
          .where('fieldId', isEqualTo: fieldId['value'])
          .get(options);

      dynamic responseData;

      if (snapshot == null || snapshot.docs.length == 0) {
        throw Exception(
            'key $key for the fieldId $fieldId not found. FUN: $smeupFun');
      }

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
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

  Future<SmeupServiceResponse> updateDocument(SmeupFun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      final id = list.firstWhere((element) => element['key'] == 'id',
          orElse: () => null);

      if (collection == null || collection.toString().isEmpty) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      if (id == null || id.toString().isEmpty) {
        throw Exception('The id is empty. FUN: $smeupFun');
      }

      var formInputFields = Map<String, dynamic>();

      for (var field in list) {
        if (field['key'] == 'collection') continue;
        if (field['key'] == 'id') continue;
        formInputFields[field['key']] = field['value'];
      }

      if (formInputFields == null || formInputFields.entries.isEmpty) {
        throw Exception(
            'The list of fields to update is empty. FUN: $smeupFun');
      }

      final checkResult = _checkDocument(formInputFields);

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

      bool isOnLine = await FirestoreShared.isInternetOn();

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
      List<Map<String, dynamic>> list = smeupFun.getParameters();

      final id = list.firstWhere((element) => element['key'] == 'id',
          orElse: () => null);

      final collection = list.firstWhere(
          (element) => element['key'] == 'collection',
          orElse: () => null);

      if (id == null || id.toString().isEmpty) {
        throw Exception('The id is empty. FUN: $smeupFun');
      }

      if (collection == null || collection.toString().isEmpty) {
        throw Exception('The collection is empty. FUN: $smeupFun');
      }

      bool isOnLine = await FirestoreShared.isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(collection['value'])
            .doc(id['value'])
            .delete();
      } else {
        fsDatabase.collection(collection['value']).doc(id['value']).delete();
      }

      SmeupVariablesService.setVariable('id', '', formKey: smeupFun.formKey);

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

    if (collection == null || collection.toString().isEmpty) {
      throw Exception('The collection is empty. FUN: $smeupFun');
    }

    var formInputFields = Map<String, dynamic>();

    for (var field in list) {
      if (field['key'] == 'collection') continue;
      formInputFields[field['key']] = field['value'];
    }

    if (formInputFields == null || formInputFields.entries.isEmpty) {
      throw Exception('The list of fields to update is empty. FUN: $smeupFun');
    }

    final checkResult = _checkDocument(formInputFields);
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
      bool isOnLine = await FirestoreShared.isInternetOn();

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

  String _checkDocument(Map<String, dynamic> smeupFun) {
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
