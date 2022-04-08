import '../services/smeup_log_service.dart';

class FunDynamism {
  String event;
  String exec;
  bool async;
  List<dynamic> targets;
  List<dynamic> variables;
  FunDynamism(this.event, this.exec, this.async, this.targets, this.variables);

  static List<FunDynamism> getDynamismsList(List<dynamic> dynFuns) {
    var list = List<FunDynamism>.empty(growable: true);

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
        final funDynamism = FunDynamism(dynFun['event'] ?? '',
            dynFun['exec'] ?? '', dynFun['async'] ?? false, targets, variables);
        list.add(funDynamism);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage(
          'Error in _getDynamisms while extracting dynamisms: $dynFuns ',
          logType: LogType.error);
    }

    return list;
  }

  static bool isDinamismAsync(String event, List<FunDynamism> dynamisms) {
    FunDynamism? dynamism = dynamisms.firstWhere(
        (element) => element.event == event,
        orElse: () => null as FunDynamism);

    return dynamism.async;
  }
}
