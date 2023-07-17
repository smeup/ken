import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import 'ken_configuration_service.dart';

enum KenLogType { none, debug, info, warning, error }

enum MessagesPromptMode { snackbar }

class KenLogService {
  static File? _logFile;

  static void writeDebugMessage(String message,
      {KenLogType logType = KenLogType.info}) async {
    String color = '\u001b[32m';
    int messageLevel = 0;
    switch (logType) {
      case KenLogType.debug:
        messageLevel = 4;
        color = '\u001b[35m';
        break;
      case KenLogType.info:
        messageLevel = 3;
        color = '\u001b[32m';
        break;
      case KenLogType.warning:
        messageLevel = 2;
        color = '\u001b[33m';
        break;
      case KenLogType.error:
        messageLevel = 1;
        color = '\u001b[31m';
        break;
      default:
        messageLevel = 0;
        color = '\u001b[32m';
    }

    int logLevel = 0;
    switch (KenConfigurationService.logLevel) {
      case KenLogType.debug:
        logLevel = 4;
        break;
      case KenLogType.info:
        logLevel = 3;
        break;
      case KenLogType.warning:
        logLevel = 2;
        break;
      case KenLogType.error:
        logLevel = 1;
        break;
      default:
        logLevel = 0;
    }

    // Errors must be always written in log

    if (messageLevel <= logLevel || logType == KenLogType.error) {
      // For printing in console the full message without truncations
      final pattern = RegExp('.{1,800}');
      pattern.allMatches(message).forEach((match) {
        String? group = match.group(0);
        if (group != null) {
          print(color + group + '\x1B[0m');
        }
      });

      if (KenConfigurationService.isLogEnabled || logType == KenLogType.error) {
        if (_logFile != null) {
          _logFile!.writeAsString('${DateTime.now().toString()}: $message \n',
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

  static Future<String?> get _localPath async {
    try {
      if (Platform.isAndroid) {
        return "/storage/emulated/0/Download";
      } else {
        final baseDir = await getApplicationDocumentsDirectory();
        return baseDir.path;
      }
    } catch (e) {
      KenLogService.writeDebugMessage('Error in getting the localPath: $e',
          logType: KenLogType.error);
      return null;
    }
  }

  static Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/log_office_booking.txt');
  }
}
