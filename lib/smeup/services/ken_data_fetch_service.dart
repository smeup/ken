class DataFetchService {
  static int _activeDataFetch = 0;

  static dynamic getEmptyDataStructure() {
    return {"messages": [], "columns": null, "rows": null, "type": ""};
  }

  static bool isDataStructure(dynamic data) {
    if (data == null) return false;
    if (data is List) return false;
    if (data['rows'] == null) {
      return false;
    }
    return true;
  }

  static void incrementDataFetch(String? id) {
    _activeDataFetch += 1;
  }

  static void decrementDataFetch(String? id) {
    if (_activeDataFetch == 0) return;
    _activeDataFetch -= 1;
  }

  static int getDataFetch() {
    return _activeDataFetch;
  }

  static void setDataFetch(int value) {
    _activeDataFetch = value;
  }

  //???
  // static void printRequestDuration(DateTime start) {
  //   if (SmeupConfigurationService.logLevel == LogType.debug) {
  //     DateTime end = DateTime.now();
  //     final diff = end.difference(start);
  //     SmeupLogService.writeDebugMessage(
  //         '_invoke dio DURATION: ${diff.inMilliseconds}ms',
  //         logType: LogType.info);
  //   }
  // }
}
