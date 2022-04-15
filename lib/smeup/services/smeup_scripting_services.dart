import 'dart:async';
import 'dart:convert';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_service_response.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';

class SmeupScriptingServices {
  static JavascriptRuntime _createRuntime(
      {@required BuildContext context,
      @required GlobalKey<FormState> formKey,
      @required GlobalKey<ScaffoldState> scaffoldKey}) {
    final js =
        getJavascriptRuntime(xhr: false, forceJavascriptCoreOnAndroid: true);

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
      }

      const dataHelper = {
        insert: async function(collection, data) {
          const staticPromise = _f2js.registerPromise();
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'insert', ...arguments]));
          return staticPromise.promise;
        },
        read: async function(collection, filters) {
          const staticPromise = _f2js.registerPromise();                
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'read', ...arguments]));
          return staticPromise.promise;
        },
        readFake: async function(collection, filters) {
          const staticPromise = _f2js.registerPromise();                
          sendMessage('DataHelper', JSON.stringify([staticPromise.promiseId, 'readFake', ...arguments]));
          return staticPromise.promise;
        },        
      }
      const helper = {
        validateRequiredField: function(fieldId, variables) {
          if (variables[fieldId].trim() === '') {
            helper.snackBar(fieldId + ' is required');
            return false;
          }
          else {
            return true;
          }
        },
        snackBar: function() {
          sendMessage('Helper', JSON.stringify(['snackBar', ...arguments]));
        }            
      }
      """;

    _jsEvaluate(context, js, code);
    js.enableHandlePromises();

    js.onMessage('Helper', (dynamic args) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(args[1])));
    });

    js.onMessage('DataHelper', (dynamic args) async {
      switch (args[1]) {
        case 'insert':
          SmeupLogService.writeDebugMessage(
              "insert in collection: ${args[1]} - data: ${args[2]}",
              logType: LogType.debug);
          dynamic _args = json.decode(args[2]);
          SmeupVariablesService.setVariable("time", _args["time"],
              formKey: formKey);
          SmeupVariablesService.setVariable("operation", _args["operation"],
              formKey: formKey);
          SmeupFun fun = SmeupFun(
              "F(FBK;FS_00_01;WRITE.DOCUMENT) NOTIFY(CLOSE()) P(collection(${args[1]}) time([time]) operation([operation]))",
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

          SmeupFun fun = SmeupFun(
              "F(EXB;FS_00_01;GET.DOCUMENTS) P(collection(${args[2]}) filters(${args[3]})))",
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
      {@required BuildContext context,
      @required GlobalKey<FormState> formKey,
      @required GlobalKey<ScaffoldState> scaffoldKey,
      @required String screenId,
      @required String script}) async {
    JavascriptRuntime js = _createRuntime(
        context: context, formKey: formKey, scaffoldKey: scaffoldKey);

    Map jsMap = Map();
    SmeupVariablesService.getVariables(formKey: formKey).forEach((key, value) {
      jsMap[key
          .toString()
          .replaceFirst(formKey.hashCode.toString() + "_", "")] = value;
    });

    var code = """        
        $script;
        validate('$screenId', JSON.parse('${json.encode(jsMap)}'));
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
