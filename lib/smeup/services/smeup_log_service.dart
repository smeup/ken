import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:mobile_components_library/smeup/models/smeup_options.dart';

enum LogType { info, warning, error }
enum MessagesPromptMode { snackbar }

class SmeupLogService {
  static File _logFile;

  static void writeDebugMessage(String message,
      {LogType logType = LogType.info}) async {
    if (SmeupConfigurationService.isDebug) {
      String color = '\u001b[32m';
      switch (logType) {
        case LogType.info:
          color = '\u001b[32m';
          break;
        case LogType.warning:
          color = '\u001b[33m';
          break;
        case LogType.error:
          color = '\u001b[31m';
          break;
        default:
          color = '\u001b[32m';
      }
      print(color + message + '\x1B[0m');
    }

    if (SmeupConfigurationService.isLogEnabled) {
      if (_logFile != null) {
        _logFile.writeAsString('${DateTime.now().toString()}: $message \n',
            mode: FileMode.append);
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
