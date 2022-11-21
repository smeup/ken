import '../services/ken_log_service.dart';

class Dynamism {
  String event;
  String exec;
  bool async;
  List<dynamic> targets;
  List<dynamic> variables;
  Dynamism(this.event, this.exec, this.async, this.targets, this.variables);

  static List<Dynamism> getDynamismsList(List<dynamic> dynFuns) {
    if (dynFuns is List<Dynamism>) return dynFuns;
    var list = List<Dynamism>.empty(growable: true);

    if (dynFuns.isEmpty) return list;

    try {
      for (var dynFun in dynFuns) {
        var targets = List<dynamic>.empty(growable: true);
        var variables = List<dynamic>.empty(growable: true);
        if (dynFun['targets'] != null) {
          targets = dynFun['targets'];
        }
        if (dynFun['variables'] != null) {
          variables = dynFun['variables'];
        }
        final funDynamism = Dynamism(dynFun['event'] ?? '',
            dynFun['exec'] ?? '', dynFun['async'] ?? false, targets, variables);
        list.add(funDynamism);
      }
    } catch (e) {
      KenLogService.writeDebugMessage(
          'Error in _getDynamisms while extracting dynamisms: $dynFuns ',
          logType: KenLogType.error);
    }

    return list;
  }

  static bool isDinamismAsync(String event, List<Dynamism> dynamisms) {
    int no = dynamisms.where((element) => element.event == event).length;

    if (no > 0) {
      Dynamism dynamism =
          dynamisms.where((element) => element.event == event).first;
      return dynamism.async;
    }

    return false;
  }
}
