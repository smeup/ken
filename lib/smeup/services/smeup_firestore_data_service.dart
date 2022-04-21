import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:dio/dio.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_data_service_interface.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';
import 'package:ken/smeup/services/transformers/null_transformer.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../models/fun.dart';
import 'smeup_data_service.dart';
import 'smeup_firestore_shared.dart';

class SmeupFirestoreDataService extends SmeupDataServiceInterface {
  FirebaseFirestore fsDatabase;

  SmeupFirestoreDataService(this.fsDatabase,
      {SmeupDataTransformerInterface? transformer})
      : super(transformer) {
    fsDatabase.settings = const Settings(persistenceEnabled: true);
  }

  @override
  Future<SmeupServiceResponse> invoke(Fun fun) async {
    switch (fun.identifier.function) {
      case "GET.DOCUMENTS":
        return await getDocuments(fun);
      case "GET.DOCUMENT":
        return await getDocument(fun);
      case "GET.INPUT.PANEL":
        return await getInputPanel(fun);
      case "GET.FIELD.DEFAULT":
      case "GET.FIELD.VALIDATION":
        return await getFieldSetting(fun);
      case "UPDATE.DOCUMENT":
        return await updateDocument(fun);
      case "DELETE.DOCUMENT":
        return await deleteDocument(fun);
      case "WRITE.DOCUMENT":
        return await writeDocument(fun);
      default:
        final message =
            'SmeupFirestoreDataService.invoke: function not implemented ${fun.toString()}';
        return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getDocuments(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.parameters;
      var checkResult = '';

      final options =
          GetOptions(source: await SmeupFirestoreShared.getSource());

      final collection =
          list.firstWhereOrNull((element) => element['key'] == 'collection');

      final filters =
          list.firstWhereOrNull((element) => element['key'] == 'filters');

      final sort = list.firstWhereOrNull((element) => element['key'] == 'sort');

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      Query<Map<String, dynamic>> query =
          fsDatabase.collection(collection!['value']);

      if (filters != null && filters.toString().isNotEmpty) {
        var parmsSplit = Fun.splitParameters(filters['value']);
        parmsSplit.forEach((element) {
          Map ds = Fun.deserilizeParameter(element);
          final key = ds['key'];
          var value = ds['value'];
          query = query.where(key, isEqualTo: value);
        });
      }

      if (sort != null && sort.toString().isNotEmpty) {
        var parmsSplit = Fun.splitParameters(sort['value']);
        parmsSplit.forEach((element) {
          Map ds = Fun.deserilizeParameter(element);
          final key = ds['key'];
          var descending = ds['value'] == 'descending';
          query = query.orderBy(key, descending: descending);
        });
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
        responseData = getTransformer()!.transform(smeupFun, snapshot);
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
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getDocuments: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getDocument(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.parameters;
      var checkResult = '';

      final options =
          GetOptions(source: await SmeupFirestoreShared.getSource());

      final collection =
          list.firstWhereOrNull((element) => element['key'] == 'collection');

      final id = list.firstWhereOrNull((element) => element['key'] == 'id');

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (id == null || id.toString().isEmpty) {
        checkResult = 'The id is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      DocumentSnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection!['value'])
          .doc(id!['value'])
          .get(options);

      dynamic responseData;

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
        responseData = getTransformer()!.transform(smeupFun, snapshot);
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
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getDocument: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getInputPanel(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.parameters;
      var checkResult = '';

      final options =
          GetOptions(source: await SmeupFirestoreShared.getSource());

      final collection =
          list.firstWhereOrNull((element) => element['key'] == 'collection');

      final name = list.firstWhereOrNull((element) => element['key'] == 'name');
      final condition =
          list.firstWhereOrNull((element) => element['key'] == 'condition');
      final fieldName =
          list.firstWhereOrNull((element) => element['key'] == 'fieldName');
      var hasCondition = false;

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }
      if (name == null || name.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (fieldName != null && fieldName.toString().isNotEmpty) {
        hasCondition = true;
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      Query<Map<String, dynamic>> query = fsDatabase
          .collection(collection!['value'])
          .where('name', isEqualTo: name!['value']);

      if (hasCondition) {
        query = query.where("fieldName", isEqualTo: fieldName!['value']);
        query = query.where("condition", isEqualTo: condition!['value']);
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

      dynamic responseData;
      dynamic res;

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
        res = getTransformer()!.transform(smeupFun, snapshot);

        responseData = SmeupDataService.getEmptyDataStructure();
        responseData["columns"] = [];
        responseData["rows"] = [];

        if ((res['rows'] as List).isNotEmpty) {
          dynamic row = res['rows'][0];
          List fields = row['fields'];
          var responseRow = Map();
          responseRow["fields"] = Map();
          if (fields.isNotEmpty) {
            for (var inputPanelField in fields) {
              (responseData["columns"] as List).add({
                "code": inputPanelField["code"],
                "IO": inputPanelField["io"],
                "text": inputPanelField["text"]
              });
              responseRow["fields"][inputPanelField["code"]] = {
                "name": inputPanelField["code"],
                "ogg": inputPanelField["ogg"],
                "value": inputPanelField["value"],
              };
            }
          }
          (responseData["rows"] as List).add(responseRow);
        }
      } else {
        final message =
            'SmeupFirestoreDataService.getInputPanel: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}';
        responseData = _getErrorResponse(message);
      }

      return SmeupServiceResponse(
          true,
          Response(
              data: responseData,
              statusCode: HttpStatus.accepted,
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getInputPanel: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> getFieldSetting(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> parameters = smeupFun.parameters;
      List<Map<String, dynamic>> server = smeupFun.server;
      var checkResult = '';

      final options =
          GetOptions(source: await SmeupFirestoreShared.getSource());

      final collection = parameters
          .firstWhereOrNull((element) => element['key'] == 'collection');

      Map<String, dynamic>? fieldPath = Map<String, dynamic>();

      fieldPath = parameters
          .firstWhereOrNull((element) => element['key'] == 'fieldPath');

      if (fieldPath == null) {
        fieldPath =
            server.firstWhereOrNull((element) => element['key'] == 'fieldPath');
      }

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (fieldPath == null || fieldPath.toString().isEmpty) {
        checkResult = 'The fieldId is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(collection!['value'])
          //.where('key', isEqualTo: key)
          .where('fieldId', isEqualTo: fieldPath!['value'])
          .get(options);

      dynamic responseData;

      if (snapshot.docs.length == 0) {
        checkResult = 'fieldId $fieldPath not found. FUN: $smeupFun';
        return _getErrorResponse(checkResult);
      }

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
        responseData = getTransformer()!.transform(smeupFun, snapshot);
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
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      final message =
          'SmeupFirestoreDataService.getDocumentDefault: ${SmeupConfigurationService.appDictionary.getLocalString('errorRetreivingInformation')}: $e';
      return _getErrorResponse(message);
    }
  }

  Future<SmeupServiceResponse> updateDocument(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.parameters;
      var checkResult = '';

      final collection =
          list.firstWhereOrNull((element) => element['key'] == 'collection');

      final id = list.firstWhereOrNull((element) => element['key'] == 'id');

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (id == null || id.toString().isEmpty) {
        checkResult = 'The id is empty. FUN: $smeupFun';
      }

      var formFields = Map<String, dynamic>();

      for (var field in list) {
        if (field['key'] == 'collection') continue;
        if (field['key'] == 'id') continue;
        formFields[field['key']] = field['value'];
      }

      if (formFields.entries.isEmpty) {
        checkResult = 'The list of fields to update is empty. FUN: $smeupFun';
      }

      //final checkResult = _checkDocument(formFields);

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(collection!['value'])
            .doc(id!['value'])
            .update(formFields);
      } else {
        fsDatabase
            .collection(collection!['value'])
            .doc(id!['value'])
            .update(formFields);
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
              requestOptions: RequestOptions(path: '')));
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
              requestOptions: RequestOptions(path: '')));
    }
  }

  Future<SmeupServiceResponse> deleteDocument(Fun smeupFun) async {
    try {
      List<Map<String, dynamic>> list = smeupFun.parameters;
      var checkResult = '';

      final id = list.firstWhereOrNull((element) => element['key'] == 'id');

      final collection =
          list.firstWhereOrNull((element) => element['key'] == 'collection');

      if (id == null || id.toString().isEmpty) {
        checkResult = 'The id is empty. FUN: $smeupFun';
      }

      if (collection == null || collection.toString().isEmpty) {
        checkResult = 'The collection is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(collection!['value'])
            .doc(id!['value'])
            .delete();
      } else {
        fsDatabase.collection(collection!['value']).doc(id!['value']).delete();
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
              requestOptions: RequestOptions(path: '')));
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in deleteDocument: $e',
          logType: LogType.error);
      return SmeupServiceResponse(
          false,
          Response(
              data: null,
              statusCode: HttpStatus.badRequest,
              requestOptions: RequestOptions(path: '')));
    }
  }

  Future<SmeupServiceResponse> writeDocument(Fun smeupFun) async {
    List<Map<String, dynamic>> list = smeupFun.parameters;
    var checkResult = '';
    final collection =
        list.firstWhereOrNull((element) => element['key'] == 'collection');

    if (collection == null || collection.toString().isEmpty) {
      checkResult = 'The collection is empty. FUN: $smeupFun';
    }

    var formFields = Map<String, dynamic>();

    for (var field in list) {
      if (field['key'] == 'collection') continue;
      formFields[field['key']] = field['value'];
    }

    if (formFields.entries.isEmpty) {
      checkResult = 'The list of fields to update is empty. FUN: $smeupFun';
    }

    //final checkResult = _checkDocument(formFields);
    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    try {
      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        final docRef =
            await fsDatabase.collection(collection!['value']).add(formFields);

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
                requestOptions: RequestOptions(path: '')));
      } else {
        fsDatabase.collection(collection!['value']).add(formFields);
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
                requestOptions: RequestOptions(path: '')));
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
              requestOptions: RequestOptions(path: '')));
    }
  }

  // String _checkDocument(Map<String, dynamic> smeupFun) {
  //   return '';
  // }

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
            requestOptions: RequestOptions(path: '')));
  }
}
