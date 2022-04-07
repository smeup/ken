import 'dart:convert';
import 'package:flutter_js/flutter_js.dart';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';

class SmeupScriptingServices {
  static JavascriptRuntime _createScriptingRuntime(BuildContext context,
      GlobalKey<FormState> formKey, GlobalKey<ScaffoldState> scaffoldKey) {
    var _flutterJs = getJavascriptRuntime(xhr: false);
    JsEvalResult _result = _flutterJs.evaluate("""
    var dataHelper = {
      insert: function(collection, data) {
        sendMessage('DataHelper', JSON.stringify(['insert', ...arguments]));
      }
    }
    var helper = {
      snackBar: function() {
        sendMessage('Helper', JSON.stringify(['snackBar', ...arguments]));
      }            
    }""");
    if (_result.isError) {
      print(_result.stringResult);
    }

    _flutterJs.onMessage('Helper', (dynamic args) async {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(args[1])));
    });

    _flutterJs.onMessage('DataHelper', (dynamic args) async {
      switch (args[0]) {
        case 'insert':
          print("insert in collection: ${args[1]} - data: ${args[2]}");
          dynamic _args = json.decode(args[2]);
          SmeupVariablesService.setVariable("time", _args["time"],
              formKey: formKey);
          SmeupVariablesService.setVariable("operation", _args["operation"],
              formKey: formKey);
          SmeupFun fun = SmeupFun(
              "F(FBK;FS_00_01;WRITE.DOCUMENT) NOTIFY(CLOSE()) P(collection(${args[1]});firestoreFields(time,operation))",
              formKey,
              scaffoldKey,
              context);
          await SmeupDataService.invoke(fun);
      }
    });
    return _flutterJs;
  }

  static bool validate(
      {required BuildContext context,
      required GlobalKey<FormState> formKey,
      required GlobalKey<ScaffoldState> scaffoldKey,
      required String screenId,
      required String script}) {
    if (script.isEmpty) return true;
    Map jsMap = Map();
    SmeupVariablesService.getVariables(formKey: formKey).forEach((key, value) {
      jsMap[key
          .toString()
          .replaceFirst(formKey.hashCode.toString() + "_", "")] = value;
    });

    JsEvalResult _result =
        _createScriptingRuntime(context, formKey, scaffoldKey).evaluate(
            "validate('$screenId', JSON.parse('${json.encode(jsMap)}'));" +
                script);

    if (_result.isError) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Error on js evaluation ${_result.stringResult}")));
      return false;
    } else {
      return _result.stringResult == "true";
    }
  }
}
