import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:ken/smeup/services/smeup_configuration_service.dart';

enum LogType { none, debug, info, warning, error }
enum MessagesPromptMode { snackbar }

class SmeupLogService {
  static File _logFile;

  static void writeDebugMessage(String message,
      {LogType logType = LogType.info}) async {
    String color = '\u001b[32m';
    int messageLevel = 0;
    switch (logType) {
      case LogType.debug:
        messageLevel = 4;
        color = '\u001b[35m';
        break;
      case LogType.info:
        messageLevel = 3;
        color = '\u001b[32m';
        break;
      case LogType.warning:
        messageLevel = 2;
        color = '\u001b[33m';
        break;
      case LogType.error:
        messageLevel = 1;
        color = '\u001b[31m';
        break;
      default:
        messageLevel = 0;
        color = '\u001b[32m';
    }

    int logLevel = 0;
    switch (SmeupConfigurationService.logLevel) {
      case LogType.debug:
        logLevel = 4;
        break;
      case LogType.info:
        logLevel = 3;
        break;
      case LogType.warning:
        logLevel = 2;
        break;
      case LogType.error:
        logLevel = 1;
        break;
      default:
        logLevel = 0;
    }

    // Errors must be always written in log

    if (messageLevel <= logLevel || logType == LogType.error) {
      print(color + message + '\x1B[0m');

      if (SmeupConfigurationService.isLogEnabled || logType == LogType.error) {
        if (_logFile != null) {
          _logFile.writeAsString('${DateTime.now().toString()}: $message \n',
              mode: FileMode.append);
        }
      }
    }
  }

  static Future<void> setLogFile() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      status = await Permission.storage.request();
    }
    if (status.isGranted) {
      _logFile = await _localFile;
    }
  }

  static Future<String> get _localPath async {
    try {
      if (Platform.isAndroid) {
        return "/storage/emulated/0/Download";
      } else {
        final baseDir = await getApplicationDocumentsDirectory();
        return baseDir.path;
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in getting the localPath: $e',
          logType: LogType.error);
      return null;
    }
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return new File('$path/log_office_booking.txt');
  }
}
