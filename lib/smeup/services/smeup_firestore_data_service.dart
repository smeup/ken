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

      final dataCollection = list
          .firstWhereOrNull((element) => element['key'] == 'dataCollection');

      final fieldsCollection = list
          .firstWhereOrNull((element) => element['key'] == 'fieldsCollection');

      final filters =
          list.firstWhereOrNull((element) => element['key'] == 'filters');

      final sort = list.firstWhereOrNull((element) => element['key'] == 'sort');

      if (dataCollection == null || dataCollection.toString().isEmpty) {
        checkResult = 'The dataCollection is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      Query<Map<String, dynamic>> query =
          fsDatabase.collection(dataCollection!['value']);

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

      if (fieldsCollection != null && fieldsCollection.toString().isEmpty) {
        //(responseData["columns"] as List)
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

      final dataCollection = list
          .firstWhereOrNull((element) => element['key'] == 'dataCollection');

      final id = list.firstWhereOrNull((element) => element['key'] == 'id');

      if (dataCollection == null || dataCollection.toString().isEmpty) {
        checkResult = 'The dataCollection is empty. FUN: $smeupFun';
      }

      if (id == null || id.toString().isEmpty) {
        checkResult = 'The id is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      DocumentSnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(dataCollection!['value'])
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

      final fieldsCollection = list
          .firstWhereOrNull((element) => element['key'] == 'fieldsCollection');
      final fields =
          list.firstWhereOrNull((element) => element['key'] == 'fields');
      final id = list.firstWhereOrNull((element) => element['key'] == 'id');
      final dataCollection = list
          .firstWhereOrNull((element) => element['key'] == 'dataCollection');

      if (fieldsCollection == null || fieldsCollection.toString().isEmpty) {
        checkResult = 'The fieldsCollection is empty. FUN: $smeupFun';
      }

      var isModify = false;
      var isIdPresent = false;
      var isDataCollectionPresent = false;
      if (id != null && id.toString().isNotEmpty) {
        isIdPresent = true;
      }
      if (dataCollection != null && dataCollection.toString().isNotEmpty) {
        isDataCollectionPresent = true;
      }

      if (isIdPresent & !isDataCollectionPresent ||
          !isIdPresent & isDataCollectionPresent) {
        checkResult =
            'The idCollection and id must be both empty or filled. FUN: $smeupFun';
      }

      if (isIdPresent & isDataCollectionPresent) {
        isModify = true;
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      Query<Map<String, dynamic>> query =
          fsDatabase.collection(fieldsCollection!['value']);

      QuerySnapshot<Map<String, dynamic>> snapshot = await query.get(options);

      dynamic responseData;
      dynamic res;

      // Apply transformation to service response (only on success)
      if (getTransformer() is NullTransformer == false) {
        res = getTransformer()!.transform(smeupFun, snapshot);

        responseData = SmeupDataService.getEmptyDataStructure();
        responseData["columns"] = [];
        responseData["rows"] = [];

        var responseRow = Map();

        if ((res['rows'] as List).isNotEmpty) {
          List fieldsArray = [];
          List cnd = [];

          if (fields != null && fields.toString().isNotEmpty) {
            fieldsArray = fields['value'].toString().split(';');
          }

          final conditionValue = list.firstWhereOrNull(
              (element) => element['key'] == 'conditionValue');
          final conditionField = list.firstWhereOrNull(
              (element) => element['key'] == 'conditionField');
          final conditionsCollection = list.firstWhereOrNull(
              (element) => element['key'] == 'conditionsCollection');
          var hasCondition = false;
          if (conditionValue != null &&
              conditionValue.toString().isNotEmpty &&
              conditionField != null &&
              conditionField.toString().isNotEmpty &&
              conditionsCollection != null &&
              conditionsCollection.toString().isNotEmpty) {
            hasCondition = true;
          }

          if (hasCondition) {
            final conditionFieldName = conditionField!['value'];
            final conditionFieldValue = SmeupVariablesService.getVariable(
                conditionFieldName,
                formKey: smeupFun.formKey);
            try {
              Query<Map<String, dynamic>> queryCondition =
                  fsDatabase.collection(conditionsCollection!['value']);
              queryCondition = queryCondition.where("conditionField",
                  isEqualTo: conditionFieldName);
              queryCondition = queryCondition.where("conditionValue",
                  isEqualTo: conditionFieldValue);
              QuerySnapshot<Map<String, dynamic>> snapshotCondition =
                  await queryCondition.get(options);
              final resCondition =
                  getTransformer()!.transform(smeupFun, snapshotCondition);
              final conditionList = resCondition!['rows'] as List;
              if (conditionList.isNotEmpty)
                cnd = conditionList[0]['fields'].toString().split(';');
            } catch (e) {}
          }

          var idRow = {};
          if (isModify) {
            DocumentSnapshot<Map<String, dynamic>> snapshotDocument =
                await fsDatabase
                    .collection(dataCollection!['value'])
                    .doc(id!['value'])
                    .get(options);
            final resId =
                getTransformer()!.transform(smeupFun, snapshotDocument);
            idRow = resId!['rows'][0];
          }

          responseRow["fields"] = Map();

          var positions = List<dynamic>.empty(growable: true);
          for (var row in (res['rows'] as List)) {
            int position = 0;

            if (cnd.isNotEmpty || fieldsArray.isNotEmpty) {
              bool isCnd = false;
              bool isFields = false;
              if (cnd.contains(row["code"]))
                isCnd = true;
              else if (fieldsArray.contains(row["code"])) isFields = true;

              if (!isCnd & !isFields) {
                continue;
              }

              if (isFields)
                position = fieldsArray.indexOf(row["code"]) + 1;
              else
                position = fieldsArray.length + cnd.indexOf(row["code"]) + 1;
            }

            if (position == 0) {
              position = int.tryParse(row['id']) ?? 0;
            }
            positions.add({"code": row["code"], "position": position});
          }

          for (var row in (res['rows'] as List)) {
            Map<String, dynamic>? col = positions.firstWhere(
                (element) => element['code'] == row["code"],
                orElse: () => null);
            if (col == null) {
              continue;
            }

            (responseData["columns"] as List).add({
              "code": row["code"],
              "IO": row["io"],
              "text": row["text"],
              "position": col['position']
            });

            var value = '';
            if (isModify) {
              value = idRow[row["code"]] ?? '';
            } else {
              value = row["value"] ?? '';
            }

            responseRow["fields"][row["code"]] = {
              "name": row["code"],
              "ogg": row["ogg"],
              "value": value,
              "validation": row["validation"]
            };
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

      final fieldSettingsCollection = parameters.firstWhereOrNull(
          (element) => element['key'] == 'fieldSettingsCollection');

      Map<String, dynamic>? fieldPath = Map<String, dynamic>();

      fieldPath = parameters
          .firstWhereOrNull((element) => element['key'] == 'fieldPath');

      if (fieldPath == null) {
        fieldPath =
            server.firstWhereOrNull((element) => element['key'] == 'fieldPath');
      }

      if (fieldSettingsCollection == null ||
          fieldSettingsCollection.toString().isEmpty) {
        checkResult = 'The fieldSettingsCollection is empty. FUN: $smeupFun';
      }

      if (fieldPath == null || fieldPath.toString().isEmpty) {
        checkResult = 'The fieldId is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      QuerySnapshot<Map<String, dynamic>> snapshot = await fsDatabase
          .collection(fieldSettingsCollection!['value'])
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

      final dataCollection = list
          .firstWhereOrNull((element) => element['key'] == 'dataCollection');

      final id = list.firstWhereOrNull((element) => element['key'] == 'id');

      if (dataCollection == null || dataCollection.toString().isEmpty) {
        checkResult = 'The dataCollection is empty. FUN: $smeupFun';
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

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(dataCollection!['value'])
            .doc(id!['value'])
            .update(formFields);
      } else {
        fsDatabase
            .collection(dataCollection!['value'])
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
    } catch (e, stacktrace) {
      SmeupLogService.writeDebugMessage(
          'Error in updateDocument: $e $stacktrace',
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

      final dataCollection = list
          .firstWhereOrNull((element) => element['key'] == 'dataCollection');

      if (id == null || id.toString().isEmpty) {
        checkResult = 'The id is empty. FUN: $smeupFun';
      }

      if (dataCollection == null || dataCollection.toString().isEmpty) {
        checkResult = 'The dataCollection is empty. FUN: $smeupFun';
      }

      if (checkResult.isNotEmpty) {
        return _getErrorResponse(checkResult);
      }

      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        await fsDatabase
            .collection(dataCollection!['value'])
            .doc(id!['value'])
            .delete();
      } else {
        fsDatabase
            .collection(dataCollection!['value'])
            .doc(id!['value'])
            .delete();
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
    final dataCollection =
        list.firstWhereOrNull((element) => element['key'] == 'dataCollection');

    if (dataCollection == null || dataCollection.toString().isEmpty) {
      checkResult = 'The dataCollection is empty. FUN: $smeupFun';
    }

    var formFields = Map<String, dynamic>();

    for (var field in list) {
      if (field['key'] == 'collection') continue;
      formFields[field['key']] = field['value'];
    }

    if (formFields.entries.isEmpty) {
      checkResult = 'The list of fields to update is empty. FUN: $smeupFun';
    }

    if (checkResult.isNotEmpty) {
      return _getErrorResponse(checkResult);
    }

    try {
      bool isOnLine = await SmeupFirestoreShared.isInternetOn();

      if (isOnLine) {
        final docRef = await fsDatabase
            .collection(dataCollection!['value'])
            .add(formFields);

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
        fsDatabase.collection(dataCollection!['value']).add(formFields);
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
