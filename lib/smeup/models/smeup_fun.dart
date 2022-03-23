import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';
import 'package:ken/smeup/services/smeup_variables_service.dart';

class SmeupFun {
  dynamic fun;
  GlobalKey<FormState> formKey;
  GlobalKey<ScaffoldState> scaffoldKey;
  BuildContext context;

  SmeupFun(dynamic dynamicFun, this.formKey, this.scaffoldKey, this.context) {
    // the object to parse is empty:
    // - return an empty SmeupFun
    if (dynamicFun == null || dynamicFun.toString().isEmpty) {
      fun = Map();
      fun['fun'] = Map();
      return;
    }

    // the object to parse is a string
    // it could be a Smeup syntax or a json string
    if (dynamicFun is String) {
      // Smeup syntax:
      // - replace the variables
      // - convert it to json object
      if (dynamicFun.startsWith('F(')) {
        _parseFromSmeupSyntax(dynamicFun);
      } else {
        // json string
        // - replace the variables
        // - parse it to json object
        fun = jsonDecode(dynamicFun);
      }
    } else {
      fun = dynamicFun;
    }

    // the object to parse is already a json object:
    // - convert it to string
    // - replace the variables
    // - parse it back to json object
    fun = _checkFunElement(fun);
    saveParameters(formKey);
  }

  SmeupFun.fromServiceName(String service) {
    fun = Map();
    fun['fun'] = Map();
    if (service == null || service.isEmpty) {
      return;
    }
    fun['fun']['component'] = '';
    fun['fun']['service'] = service;
    fun['fun']['function'] = '';
  }

  dynamic _checkFunElement(dynamicFun) {
    if (dynamicFun != null &&
        (dynamicFun as Map).entries.length > 0 &&
        dynamicFun['fun'] == null) {
      Map newEl = {'fun': dynamicFun};
      dynamicFun = newEl;
    }

    return dynamicFun;
  }

  List<Map<String, dynamic>> getParameters() {
    var list = List<Map<String, dynamic>>.empty(growable: true);

    if (fun['fun'] == null) return list;

    final parms = fun['fun']['P'];

    if (parms == null || parms.isEmpty) return list;

    List<String> parmsSplit = parms.split(';');
    if (parmsSplit.length == 0) return list;

    try {
      parmsSplit.forEach((parm) {
        parm = parm.trim();
        RegExp re = RegExp(r'\([^)]*\)');
        re.allMatches(parm).forEach((match) {
          final key = parm.substring(0, parm.indexOf('('));
          var value = parm
              .substring(match.start, match.end)
              .replaceFirst('(', '')
              .replaceFirst(')', '');
          if (key != null && key.isNotEmpty) {
            if (value.toString().startsWith('[')) {
              String varName = value
                  .toString()
                  .trim()
                  .replaceAll('[', '')
                  .replaceAll(']', '');
              value =
                  SmeupVariablesService.getVariable(varName, formKey: formKey)
                      .toString();
            } else {
              value = value;
            }
            list.add({'key': key, 'value': value});
          }
        });
      });
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in _parseFromSmeupSyntax while extracting P: $parms ',
          logType: LogType.error);
    }

    return list;
  }

  void saveParameters(GlobalKey<FormState> formKey) {
    List<Map<String, dynamic>> list = getParameters();
    list.forEach((element) {
      SmeupVariablesService.setVariable(element['key'], element['value'],
          formKey: formKey);
    });
  }

  _parseFromSmeupSyntax(String funString) {
    fun = Map();
    fun['fun'] = Map();

    fun['fun']['component'] = '';
    fun['fun']['service'] = '';
    fun['fun']['function'] = '';
    fun['fun']['obj1'] = Map();
    fun['fun']['obj2'] = Map();
    fun['fun']['obj3'] = Map();
    fun['fun']['obj4'] = Map();
    fun['fun']['obj5'] = Map();
    fun['fun']['obj6'] = Map();
    fun['fun']['P'] = '';
    fun['fun']['parentFun'] = '';
    fun['fun']['INPUT'] = '';
    fun['fun']['SG'] = {'cache': 0, 'forceCache': false};
    fun['fun']['G'] = '';

    funString = funString.replaceAll(' (', '(');
    funString = ' $funString';
    String arg = '';

    arg = extractArg(funString, 'F');
    var argSplit = arg.split(';');
    if (argSplit.length > 0) fun['fun']['component'] = argSplit[0];
    if (argSplit.length > 1) fun['fun']['service'] = argSplit[1];
    if (argSplit.length > 2) fun['fun']['function'] = argSplit[2];

    for (var i = 1; i < 7; i++) {
      arg = extractArg(funString, i.toString());
      argSplit = arg.split(';');
      String valT = '';
      String valP = '';
      String valK = '';
      if (argSplit.length > 0) valT = argSplit[0];
      if (argSplit.length > 1) valP = argSplit[1];
      if (argSplit.length > 2) valK = argSplit[2];

      fun['fun']['obj$i']['t'] = valT;
      fun['fun']['obj$i']['p'] = valP;
      fun['fun']['obj$i']['k'] = valK;
    }

    arg = extractArg(funString, 'P');
    fun['fun']['P'] = arg;

    arg = extractArg(funString, 'INPUT');
    fun['fun']['INPUT'] = arg;

    arg = extractArg(funString, 'NOTIFY');
    fun['fun']['NOTIFY'] = arg;

    arg = extractArg(funString, 'SG');
    argSplit = arg.split(',');
    String val1 = '';
    String val2 = '';
    if (argSplit.length > 0) val1 = argSplit[0].trim();
    if (argSplit.length > 1) val2 = argSplit[1].trim();
    String cache =
        extractArg(val1.contains('cache') ? val1 : val2, 'cache', prefix: '');
    String forceCache = extractArg(
        val1.contains('forceCache') ? val1 : val2, 'forceCache',
        prefix: '');
    fun['fun']['SG'] = {
      "cache": int.tryParse(cache),
      "forceCache": forceCache.toLowerCase() == 'yes' ? true : false
    };

    arg = extractArg(funString, 'G');
    fun['fun']['G'] = arg;

    arg = extractArg(funString, 'parentFun');
    fun['fun']['parentFun'] = arg;
  }

  static String extractArg(String funString, String parm,
      {String prefix = ' '}) {
    String arg = '';

    if (funString.startsWith(parm)) {
      funString = prefix + funString;
    }

    int startIdx = funString.indexOf('$prefix$parm(');
    if (startIdx >= 0) {
      startIdx += (parm.length + prefix.length);

      int endIdx = 0;

      //endIdx = funString.indexOf(')', startIdx);
      int parCount = 0;
      final split = funString.split('');
      for (var i = startIdx; i < split.length; i++) {
        final character = split[i];
        if (character == '(') parCount += 1;
        if (character == ')') {
          parCount -= 1;
          if (parCount == 0) {
            endIdx = i;
            break;
          }
        }
      }

      arg = funString.substring(startIdx, endIdx);
      if (arg.startsWith('(')) arg = arg.substring(1);
    }
    return arg;
  }

  bool isFunValid() {
    if (fun != null &&
        (fun['fun'] as Map) != null &&
        (fun['fun'] as Map).entries.length > 0) return true;
    return false;
  }

  bool isDinamismAsync(List dynamisms, String event) {
    if (dynamisms == null) return true;

    Map dynamism = dynamisms.firstWhere((element) => element['event'] == event,
        orElse: () => null);

    if (dynamism == null) return true;

    if (dynamism['async'] == null ||
        !(dynamism['async'] is bool) ||
        dynamism['async'] == true) return true;

    return false;
  }
}
