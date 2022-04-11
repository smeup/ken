import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ken/smeup/models/fun_SG.dart';
import 'package:ken/smeup/models/fun_object.dart';

import '../services/smeup_dynamism_service.dart';
import '../services/smeup_log_service.dart';
import '../services/smeup_variables_service.dart';
import 'fun_identifier.dart';

class SmeupFun {
  GlobalKey<FormState>? formKey;
  GlobalKey<ScaffoldState>? scaffoldKey;
  BuildContext? context;

  late List<Map<String, dynamic>> parameters;
  late List<Map<String, dynamic>> server;
  late FunIdentifier identifier;
  late List<FunObject> objects;
  late String input;
  late FunSG funSG;
  late String G;
  late String notify;

  SmeupFun(dynamic dynamicFun, this.formKey, this.scaffoldKey, this.context) {
    _init();

    // the object to parse is empty:
    // - return an empty SmeupFun
    if (dynamicFun == null || dynamicFun.toString().isEmpty) {
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
        dynamic _fun = jsonDecode(dynamicFun);
        _parseFromJson(_fun);
      }
    } else {
      _parseFromJson(dynamicFun);
    }

    // the object to parse is already a json object:
    // - convert it to string
    // - replace the variables
    // - parse it back to json object

    //_fun = _checkFunElement(_fun);
    saveParametersToVariables(formKey);
  }

  SmeupFun.fromServiceName(String service) {
    _init();

    if (service.isEmpty) {
      return;
    }
    identifier.service = service;
  }

  _init() {
    parameters = List<Map<String, dynamic>>.empty(growable: true);
    server = List<Map<String, dynamic>>.empty(growable: true);
    identifier = FunIdentifier('', '', '');
    objects = List<FunObject>.empty(growable: true);
    for (var i = 1; i < 7; i++) {
      objects.add(FunObject('obj$i', '', '', ''));
    }
    input = '';
    funSG = FunSG(0, false);
    G = '';
    notify = '';
  }

  _parseFromSmeupSyntax(String funString) {
    funString = funString.replaceAll(' (', '(');
    funString = ' $funString';

    identifier = _getIdentifier(funString);

    objects = _getObjects(funString);

    parameters = _getParameters(funString);

    input = extractArg(funString, 'INPUT');

    notify = extractArg(funString, 'NOTIFY');

    funSG = _getFunSG(funString);

    G = extractArg(funString, 'G');

    server = _getServer(funString);
  }

  _parseFromJson(dynamic dynamicFun) {
    dynamic newFun = _checkFunElement(dynamicFun);
    identifier = FunIdentifier(newFun['fun']['component'] ?? '',
        newFun['fun']['service'] ?? '', newFun['fun']['function'] ?? '');

    for (var i = 1; i < 7; i++) {
      String objName = 'obj$i';
      dynamic obj = newFun['fun'][objName];
      if (obj != null) {
        FunObject funObject = FunObject(objName, obj['t'], obj['p'], obj['k']);
        objects.add(funObject);
      }
    }

    if (newFun['fun']['P'] != null) {
      parameters = extractParametersList(newFun['fun']['P'], formKey);
    }

    if (newFun['fun']['INPUT'] != null) {
      input = newFun['fun']['INPUT'];
    }

    if (newFun['fun']['NOTIFY'] != null) {
      notify = newFun['fun']['NOTIFY'];
    }

    if (newFun['fun']['SG'] != null) {
      funSG = FunSG(newFun['fun']['SG']['cache'] ?? 0,
          newFun['fun']['SG']['forceCache'] ?? false);
    }

    if (newFun['fun']['G'] != null) {
      G = newFun['fun']['G'];
    }

    if (newFun['fun']['SERVER'] != null) {
      server = extractParametersList(newFun['fun']['SERVER'], formKey);
    }
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

  FunIdentifier _getIdentifier(String funString) {
    String arg = extractArg(funString, 'F');
    var argSplit = arg.split(';');
    var id = FunIdentifier('', '', '');
    if (argSplit.length > 0) {
      id.component = argSplit[0];
    }
    if (argSplit.length > 1) {
      id.service = argSplit[1];
    }
    if (argSplit.length > 2) {
      id.function = argSplit[2];
    }
    return id;
  }

  List<Map<String, dynamic>> _getParameters(String funString) {
    var list = List<Map<String, dynamic>>.empty(growable: true);

    String arg = extractArg(funString, 'P');

    try {
      list = extractParametersList(arg, formKey);
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in _getParameters while extracting P: $arg ',
          logType: LogType.error);
    }

    return list;
  }

  List<Map<String, dynamic>> _getServer(String funString) {
    var list = List<Map<String, dynamic>>.empty(growable: true);

    String arg = extractArg(funString, 'SERVER');

    try {
      list = extractParametersList(arg, formKey);
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in _getServer while extracting SERVER: $arg ',
          logType: LogType.error);
    }

    return list;
  }

  _getObjects(String funString) {
    var list = List<FunObject>.empty(growable: true);
    for (var i = 1; i < 7; i++) {
      String arg = extractArg(funString, i.toString());
      var argSplit = arg.split(';');
      String valT = '';
      String valP = '';
      String valK = '';
      if (argSplit.length > 0) valT = argSplit[0];
      if (argSplit.length > 1) valP = argSplit[1];
      if (argSplit.length > 2) valK = argSplit[2];
      list.add(FunObject('obj$i', valT, valP, valK));
    }
    return list;
  }

  FunSG _getFunSG(String funString) {
    String arg = extractArg(funString, 'SG');
    var argSplit = arg.split(',');
    String val1 = '';
    String val2 = '';
    if (argSplit.length > 0) val1 = argSplit[0].trim();
    if (argSplit.length > 1) val2 = argSplit[1].trim();
    String cache =
        extractArg(val1.contains('cache') ? val1 : val2, 'cache', prefix: '');
    String forceCache = extractArg(
        val1.contains('forceCache') ? val1 : val2, 'forceCache',
        prefix: '');
    final funSG = FunSG(int.tryParse(cache) ?? 0,
        forceCache.toLowerCase() == 'yes' ? true : false);
    return funSG;
  }

  static List<Map<String, dynamic>> extractParametersList(
      String parms, GlobalKey<FormState>? formKey) {
    var list = List<Map<String, dynamic>>.empty(growable: true);

    var parmsSplit = splitParameters(parms);

    if (parmsSplit.length == 0) return list;

    parmsSplit.forEach((parm) {
      parm = parm.trim();
      RegExp re = RegExp(r'\([^)]*\)');
      re.allMatches(parm).forEach((match) {
        Map ds = deserilizeParameter(parm);
        final key = ds['key'];
        var value = ds['value'];

        if (key != null && key.isNotEmpty) {
          if (value.toString().startsWith('[')) {
            String varName =
                value.toString().trim().replaceAll('[', '').replaceAll(']', '');
            value = SmeupVariablesService.getVariable(varName, formKey: formKey)
                .toString();
          } else {
            value = value;
          }
          list.add({'key': key, 'value': value});
        }
      });
    });

    return list;
  }

  static List<String> splitParameters(String parms) {
    var parmsSplit = List<String>.empty(growable: true);
    RegExp re =
        RegExp(r'[a-zA-Z0-9]+\(+(?<=\()(?:[^()]+|\([^)]+\))+(?=\))*\)*\)');
    re.allMatches(parms).forEach((match) {
      var parm = parms.substring(match.start, match.end);
      //print(parm);
      parmsSplit.add(parm);
    });
    return parmsSplit;
  }

  static Map deserilizeParameter(String parm) {
    final key = parm.substring(0, parm.indexOf('('));

    int indIni = parm.indexOf("(");
    int indEnd = parm.lastIndexOf(")");
    var value = parm.substring(indIni + 1, indEnd);

    return {"key": key, "value": value};
  }

  void saveParametersToVariables(GlobalKey<FormState>? formKey) {
    parameters.forEach((element) {
      SmeupVariablesService.setVariable(element['key'], element['value'],
          formKey: formKey);
    });
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
    if (identifier.isValid()) return true;
    return false;
  }

  FunObject getObjectByName(String name) {
    return objects.firstWhere((element) => element.name == name,
        orElse: () => null as FunObject);
  }

  replaceVariables() {
    String funString = this.getSmeupFormatString();
    funString = SmeupDynamismService.replaceVariables(funString, formKey);
    SmeupFun newFun =
        SmeupFun(funString, this.formKey, this.scaffoldKey, this.context);
    parameters = newFun.parameters;
    server = newFun.server;
    identifier = newFun.identifier;
    objects = newFun.objects;
    input = newFun.input;
    funSG = newFun.funSG;
    G = newFun.G;
    notify = newFun.notify;
  }

  getJson() {
    var fun = Map();
    fun['fun'] = Map();

    fun['fun']['component'] = identifier.component;
    fun['fun']['service'] = identifier.service;
    fun['fun']['function'] = identifier.function;

    for (var i = 1; i < 7; i++) {
      FunObject funObject = getObjectByName('obj$i');
      fun['fun']['obj$i'] = Map();
      fun['fun']['obj$i']['t'] = funObject.t;
      fun['fun']['obj$i']['p'] = funObject.p;
      fun['fun']['obj$i']['k'] = funObject.k;
    }

    if (parameters.length > 0) {
      String parmsStr = 'P(';
      for (var p = 0; p < parameters.length; p++) {
        final parm = parameters[p];
        final sep = p < parameters.length - 1 ? ' ' : '';
        parmsStr += '${parm["key"]}(${parm["value"]})$sep';
      }
      parmsStr += ')';
      fun['fun']['P'] = ' $parmsStr';
    } else {
      fun['fun']['P'] = '';
    }

    if (server.length > 0) {
      String serverStr = 'SERVER(';
      for (var p = 0; p < server.length; p++) {
        final parm = server[p];
        final sep = p < server.length - 1 ? ' ' : '';
        serverStr += '${parm["key"]}(${parm["value"]})$sep';
      }
      serverStr += ')';
      fun['fun']['SERVER'] = ' $serverStr';
    }

    fun['fun']['INPUT'] = input;
    fun['fun']['SG'] = {'cache': funSG.cache, 'forceCache': funSG.forceCache};
    fun['fun']['G'] = G;
    fun['fun']['NOTIFY'] = notify;

    return fun;
  }

  String getSmeupFormatString() {
    String smeupFormatString = '';

    // ----

    try {
      // function
      String function = 'F(';
      function += identifier.component;
      function += ';';
      function += identifier.service;
      function += ';';
      function += identifier.function;
      function += ')';
      smeupFormatString += function;

      // objects
      for (var i = 1; i < 7; i++) {
        String object = '';

        FunObject funObject = getObjectByName('obj$i');

        String valT = funObject.t.trim();
        String valP = funObject.p.trim();
        String valK = funObject.k.trim();
        if (valT.isNotEmpty || valP.isNotEmpty || valK.isNotEmpty)
          object = '$i($valT;$valP;$valK)';

        if (object.isNotEmpty) {
          smeupFormatString += ' $object';
        }
      }

      // parameters
      if (parameters.length > 0) {
        String parmsStr = 'P(';
        for (var p = 0; p < parameters.length; p++) {
          final parm = parameters[p];
          final sep = p < parameters.length - 1 ? ' ' : '';
          parmsStr += '${parm["key"]}(${parm["value"]})$sep';
        }
        parmsStr += ')';
        smeupFormatString += ' $parmsStr';
      }

      // INPUT
      if (input.isNotEmpty) {
        smeupFormatString += ' INPUT($input)';
      }

      // G
      if (G.isNotEmpty) {
        smeupFormatString += ' G($G)';
      }

      // SERVER

      if (server.length > 0) {
        String serverStr = 'SERVER(';
        for (var p = 0; p < server.length; p++) {
          final parm = server[p];
          final sep = p < server.length - 1 ? ' ' : '';
          serverStr += '${parm["key"]}(${parm["value"]})$sep';
        }
        serverStr += ')';
        smeupFormatString += ' $serverStr';
      }

      // ----

    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in _parseFromSmeupSyntax while getSmeupFormatString : $this ',
          logType: LogType.error);
    }
    return smeupFormatString;
  }
}
