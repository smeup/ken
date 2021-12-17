import 'package:flutter/material.dart';
//import 'package:ken/smeup/services/smeup_configuration_service.dart';
import 'package:ken/smeup/services/smeup_log_service.dart';

class SmeupVariablesService {
  static Map _globalVariables = Map();
  static Map _formVariables = Map();

  static dynamic getVariable(String key, {GlobalKey<FormState> formKey}) {
    var value = _formVariables['${formKey.hashCode.toString()}_$key'];
    if (value == null) {
      value = _globalVariables[key];
    }
    return value;
  }

  static setVariable(String key, dynamic value,
      {GlobalKey<FormState> formKey}) {
    var workKey = key;
    if (formKey == null) {
      _globalVariables[workKey] = value;

      if (_globalVariables[workKey] == null) {
        SmeupLogService.writeDebugMessage(
            "Added the global variable : $workKey, value: $value",
            logType: LogType.debug);
      } else {
        SmeupLogService.writeDebugMessage(
            "Changed the global variable : $workKey, value: $value",
            logType: LogType.debug);
      }
    } else {
      workKey = '${formKey.hashCode.toString()}_$key';

      _formVariables[workKey] = value;

      if (_formVariables[workKey] == null) {
        SmeupLogService.writeDebugMessage(
            "Added the form variable : $workKey, value: $value",
            logType: LogType.debug);
      } else {
        SmeupLogService.writeDebugMessage(
            "Changed the form variable : $workKey, value: $value",
            logType: LogType.debug);
      }
    }
  }

  static Map getVariables({GlobalKey<FormState> formKey}) {
    return SmeupVariablesService._getJoinMap(formKey: formKey);
  }

  static void dumpVariables({GlobalKey<FormState> formKey}) {
    SmeupVariablesService._getJoinMap(formKey: formKey).forEach((key, value) {
      SmeupLogService.writeDebugMessage(
          "Dump variables - Variables status: $key=\"$value\"",
          logType: LogType.debug);
    });
  }

  static void removeFormVariables(GlobalKey<FormState> formKey) {
    if (formKey != null) {
      SmeupVariablesService._formVariables.removeWhere((key, value) =>
          key.toString().startsWith(formKey.hashCode.toString()));

      SmeupLogService.writeDebugMessage(
          "Removed all form variables : ${formKey.hashCode}",
          logType: LogType.debug);
    }
  }

  static void removeVariable(String key, {GlobalKey<FormState> formKey}) {
    if (formKey == null) {
      _globalVariables.remove(key);

      SmeupLogService.writeDebugMessage("Removed the global variable : $key",
          logType: LogType.debug);
    } else {
      _formVariables.remove(key);

      SmeupLogService.writeDebugMessage("Removed the form variable : $key",
          logType: LogType.debug);
    }
  }

  static Map _getJoinMap({GlobalKey<FormState> formKey}) {
    var join = Map();

    join.addEntries(_globalVariables.entries);

    if (formKey == null)
      join.addEntries(_formVariables.entries);
    else
      join.addEntries(_formVariables.entries.where((element) =>
          element.key.toString().startsWith(formKey.hashCode.toString())));

    return join;
  }
}
