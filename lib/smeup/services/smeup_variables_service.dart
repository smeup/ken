import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';

class SmeupVariablesService {
  static Map _globalVariables = Map();
  static Map _formVariables = Map();

  static dynamic getVariable(String key, {String form = ''}) {
    var value = _formVariables[form + key];
    if (value == null) {
      value = _globalVariables[key];
    }
    return value;
  }

  static setVariable(String key, dynamic value, {String form = ''}) {
    if (form.isEmpty) {
      _globalVariables[key] = value;
    } else {
      _formVariables[form + key] = value;
    }
  }

  static Map getVariables({String form = ''}) {
    return SmeupVariablesService._getJoinMap(form: form);
  }

  static void dumpVariables({String form = ''}) {
    SmeupVariablesService._getJoinMap(form: form).forEach((key, value) {
      SmeupLogService.writeDebugMessage(
          "Dump variables - Variables status: $key=\"$value\"",
          logType: LogType.info);
    });
  }

  static Map _getJoinMap({String form}) {
    var join = Map();

    join.addEntries(_globalVariables.entries);

    if (form.isEmpty)
      join.addEntries(_formVariables.entries);
    else
      join.addEntries(_formVariables.entries
          .where((element) => element.key.toString().startsWith(form)));

    return join;
  }
}
