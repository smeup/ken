import 'dart:async';
import 'dart:convert';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';

import '../models/fun.dart';

/// JavaScript snippets supported
///
/// Read data
/// ```javascript
/// dataHelper.read(collectionName, filters);
/// ```
///
/// In example below we read from a collection with name locked-surnames the first
/// document with attribute surname, equals to variables.surname.
/// The value returned is an empty map if the document is missing
///
/// ```javascript
/// var record = await dataHelper.read('locked-surnames', {surname: variables.surname});
/// ```
///
/// Insert data
/// ```javascript
/// dataHelper.insert(collection, data);
/// ```
///
/// In the example below we insert some data into a collection with name audit
///
/// ```javascript
/// dataHelper.insert('audit', {surname: variables.surname, time: Date.now(), operation: 'insert'});
/// ```
/// Display a message from javascript
/// ```javascript
/// helper.snackBar(message);
/// ```
///
/// In the example below we display a message to the user informing him
/// the object is locked
///
/// ```javascript
/// helper.snackBar("You can't modify this object because is locked");
/// ```
/// Required fields
/// ```javascript
/// var validated = helper.validateRequiredField(field, variables);
/// ```
///
///
/// How to implement a field validation script
/// All functions must have this signature and returns always a boolean value
/// ```javascript
/// async validate(field, variables);
/// ```
/// fieldId is the field identifier, and variables is a map which contains all
/// form variables
///
/// In the example below we'll use all snippets previously described
///
/// ```javascript
/// async function validate(field, variables) {
///   var validated = helper.validateRequiredField(field);
///   if (validated) {
///     var record = await dataHelper.read('locked-surnames', {surname: variables.surname});
///     validated = record.surname != variables.surname;
///     if (!validated) {
///       helper.snackBar("You can't modify this customer, because " + record.surname + " is locked");
///     } else {
///       dataHelper.insert('audit', {surname: variables.surname, time: Date.now(), operation: 'insert'});
///     }
///   };
///   return validated;
/// }
/// ```
class SmeupScriptingServices {
  static JavascriptRuntime _createRuntime(
      {required BuildContext context,
      GlobalKey<FormState>? formKey,
      required GlobalKey<ScaffoldState> scaffoldKey}) {
    // For using JSCore on android set forceJavascriptCoreOnAndroid to true
    // and in app/build.gradle uncomment the dependency to
    // com.github.fast-development.android-js-runtimes:fastdev-jsruntimes-jsc:0.1.3
    final js =
        getJavascriptRuntime(xhr: false, forceJavascriptCoreOnAndroid: false);

    String code = """
      const _f2js = {
        map: {},        
        id: 0,      
        registerPromise: function() {
          var promise = this.createStaticPromise();           
          this.map[promise.promiseId] = promise;
          return promise;
        },                
        resolvePromise: function(promiseId, value) {          
          if (!this.map[promiseId])
              throw new Error("Can't resolve promise with id ".concat(promiseId, ". It doesn't exist."));
          this.map[promiseId].resolve(value);
          delete this.map[promiseId];
        },
        rejectPromise: function(promiseId, value) {
          if (!this.map[promiseId])
              throw new Error("Can't reject promise with id ".concat(promiseId, ". It doesn't exist."));
          this.map[promiseId].reject(value);
          delete this.map[promiseId];                  
        },
        createStaticPromise: function() {
          var staticPromise = {};
          staticPromise.promiseId = this.id++;
          staticPromise.promise = new Promise(function (resolve, reject) {
              staticPromise.resolve = resolve;
              staticPromise.reject = reject;
          });
          return staticPromise;
        },
      };

      const dataHelper = {
        insert: async function(collection, data) {
          const staticPromise = _f2js.registerPromise();
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'insert', collection, JSON.stringify(data)]));
          return staticPromise.promise;
        },
        read: async function(collection, filters) {
          const staticPromise = _f2js.registerPromise();                
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'read', collection, JSON.stringify(filters)]));
          return staticPromise.promise;
        },
        readFake: async function(collection, filters) {
          const staticPromise = _f2js.registerPromise();                
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'readFake', collection, filters]));
          return staticPromise.promise;
        },        
      };

      const helper = {
        validateObjectField: async function(field) {
          var value = field.value;
          var record = await dataHelper.read(field.ogg, {code: value});
          if (record.code === undefined) {
            record = await dataHelper.read(field.ogg, {description: value});                        
          }
          if (record.code === undefined) {
            helper.alert("Code or description specified in field with label " + field.text + " is not valid");
            return false;
          }
          else {
            return true;
          }
        },
        validateRequiredField: function(field) {
          var value = field.value;
          if (value === undefined || value === null || value.trim() === '') {
            helper.alert("Field with label " + field.text + ' is required');
            return false;
          }
          else {
            return true;
          }
        },
        snackBar: function(message) {
          sendMessage('Helper', JSON.stringify(['snackBar', message]));
        },
        alert: function(message) {
          sendMessage('Helper', JSON.stringify(['alert', message]));
        },
      }
      """;

    _jsEvaluate(context, js, code);
    js.enableHandlePromises();

    js.onMessage('Helper', (dynamic args) async {
      switch (args[0]) {
        case 'snackBar':
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(duration: Duration(seconds: 3), content: Text(args[1])));
          break;
        case 'alert':
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red.shade700,
            content: Text(args[1]),
          ));
      }
    });

    js.onMessage('DataHelper', (dynamic args) async {
      switch (args[1]) {
        case 'insert':
          SmeupLogService.writeDebugMessage(
              "insert in collection: ${args[2]} - data: ${args[3]}",
              logType: LogType.debug);
          dynamic _args = json.decode(args[3]);
          var funParameter = StringBuffer();
          (_args as Map).forEach((key, value) {
            // I don't like very much, this can overwrite other variables
            SmeupVariablesService.setVariable(key, value);
            funParameter.write("$key([$key]) ");
          });

          Fun fun = Fun(
              "F(FBK;FS_00_01;WRITE.DOCUMENT) NOTIFY(CLOSE()) P(fieldSettingsCollection(${args[2]}) $funParameter)",
              formKey,
              scaffoldKey,
              context);
          await SmeupDataService.invoke(fun);
          _jsEvaluate(context, js, "_f2js.resolvePromise(${args[0]})");
          break;

        case 'read':
          SmeupLogService.writeDebugMessage(
              "Read from collection: ${args[2]} - filters: ${args[3]}",
              logType: LogType.debug);

          dynamic _args = json.decode(args[3]);
          var funParameter = StringBuffer();

          (_args as Map).forEach((key, value) {
            funParameter.write("$key($value)");
          });

          Fun fun = Fun(
              "F(EXB;FS_00_01;GET.DOCUMENTS) P(dataCollection(${args[2]}) filters($funParameter)))",
              formKey,
              scaffoldKey,
              context);
          SmeupServiceResponse resp = await SmeupDataService.invoke(fun);
          List rows = resp.result.data['rows'] as List;
          dynamic result = rows.length > 0 ? rows[0] : {};
          SmeupLogService.writeDebugMessage(result.toString(),
              logType: LogType.debug);
          _jsEvaluate(context, js,
              "_f2js.resolvePromise(${args[0]}, JSON.parse('${json.encode(result)}'))");
          break;

        case 'readFake':
          await Future.delayed(
            const Duration(milliseconds: 1000),
            () => args[2].toString().toUpperCase(),
          );
          Map result = {"surname": "lanari"};
          _jsEvaluate(context, js,
              "_f2js.resolvePromise(${args[0]}, JSON.parse('${json.encode(result)}'))");
      }
    });
    return js;
  }

  static Future<bool> validate(
      {required BuildContext context,
      GlobalKey<FormState>? formKey,
      required GlobalKey<ScaffoldState> scaffoldKey,
      Map? field,
      String? script}) async {
    if (formKey == null || field == null || script == null) {
      SmeupLogService.writeDebugMessage(
          "Unable to validate because formKey or fieldId or script is not specified",
          logType: LogType.error);
      return false;
    }
    JavascriptRuntime js = _createRuntime(
        context: context, formKey: formKey, scaffoldKey: scaffoldKey);

    Map jsMap = Map();
    SmeupVariablesService.getVariables(formKey: formKey).forEach((key, value) {
      jsMap[key
          .toString()
          .replaceFirst(formKey.hashCode.toString() + "_", "")] = value;
    });
    field["value"] = jsMap[field["code"]];

    var code = """                
        $script
        validate(JSON.parse('${json.encode(field)}'), JSON.parse('${json.encode(jsMap)}'));        
        """;

    var asyncResult = await js.evaluateAsync(code);
    if (asyncResult.isError) {
      _logError(context, asyncResult.stringResult, code);
    }
    js.executePendingJob();
    try {
      return (await js.handlePromise(asyncResult)).stringResult == "true";
    } catch (err) {
      _logError(context, err.toString(), code);
      return false;
    }
  }

  static bool _jsEvaluate(
      BuildContext context, JavascriptRuntime js, String code) {
    var result = js.evaluate(code);
    if (result.isError) {
      _logError(context, result.stringResult, code);
      return false;
    } else {
      return true;
    }
  }

  static void _logError(
      BuildContext context, String errorMessage, String code) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("JavaScript error: $errorMessage check logs")));
    SmeupLogService.writeDebugMessage(
        "Error $errorMessage\nIn current js:\n${_addRowLine(code)}",
        logType: LogType.error);
  }

  static String _addRowLine(String code) {
    var strBuff = StringBuffer();
    int rowNumber = 1;
    code.split("\n").forEach((row) {
      strBuff.write(rowNumber.toString().padLeft(2, '0'));
      strBuff.writeln(row);
      rowNumber++;
    });
    return strBuff.toString();
  }
}
