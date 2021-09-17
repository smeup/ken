import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobile_components_library/smeup/models/smeup_fun.dart';
import 'package:mobile_components_library/smeup/services/smeup_data_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_log_service.dart';
import 'package:mobile_components_library/smeup/services/smeup_variables_service.dart';

class SmeupMemoryService {
  static Map memory = Map();
  static bool _isMemoryBusy = false;

  static Future<dynamic> getMemory(String key, String segment,
      SmeupFun smeupFun, Function dataFunction) async {
    if (memory[key] != null) {
      SmeupLogService.writeDebugMessage(
          'response returned from the $key memory',
          logType: LogType.info);
      return memory[key][segment];
    } else {
      if (_isMemoryBusy) {
        //final int waitForMemory = 1500;
        var start = DateTime.now();
        // SmeupLogService.writeDebugMessage(
        //     'response returned from  $key memory after waiting $waitForMemory milliseconds',
        //     logType: LogType.info);
        // return await Future.delayed(Duration(milliseconds: waitForMemory),
        //     () async => memory[key][segment]);
        return _waitWhileBusy(3000, start, key, segment);
      } else {
        _isMemoryBusy = true;
        SmeupLogService.writeDebugMessage('response added to the $key memory',
            logType: LogType.info);

        await _getValue(key, segment, smeupFun, dataFunction);

        _isMemoryBusy = false;
        return memory[key] != null && memory[key][segment] != null
            ? memory[key][segment]
            : null;
      }
    }
  }

  static Future<dynamic> _waitWhileBusy(
      int timeout, DateTime start, String key, String segment) {
    try {
      return Future(() {
        var diff = DateTime.now().difference(start);
        if (!_isMemoryBusy) {
          return memory[key][segment];
        } else {
          if (diff.inMilliseconds > timeout) {
            return null;
          } else {
            return Future.delayed(Duration(milliseconds: 100))
                .then((value) => _waitWhileBusy(timeout, start, key, segment));
          }
        }
      });
    } catch (e) {}
    return Future(() {
      return null;
    });
  }

  static Future<void> _getValue(String key, String segment, SmeupFun smeupFun,
      Function dataFunction) async {
    final urlProperties = 'devices/${smeupFun.fun['fun']['obj1']['k']}';
    var responseProperties =
        await dataFunction(smeupFun, urlProperties, 'get', 'application/json');
    final responsePropertiesValid =
        SmeupDataService.isValid(responseProperties.statusCode);

    var memoryDevice;
    if (SmeupVariablesService.getVariable('productId') == '108') {
      final urlZones = 'devices/${smeupFun.fun['fun']['obj1']['k']}/zones';
      var responseZones =
          await dataFunction(smeupFun, urlZones, 'get', 'application/json');
      final responseZonesValid =
          SmeupDataService.isValid(responseZones.statusCode);

      final urlConfig = 'devices/${smeupFun.fun['fun']['obj1']['k']}/config';
      var responseConfig =
          await dataFunction(smeupFun, urlConfig, 'get', 'application/json');
      final responseConfigValid =
          SmeupDataService.isValid(responseConfig.statusCode);

      if (responsePropertiesValid &&
          responseConfigValid &&
          responseZonesValid) {
        memoryDevice = {
          'properties': responseProperties,
          'zones': responseZones,
          'config': responseConfig
        };
        memory[key] = memoryDevice;
      }
    } else {
      if (responsePropertiesValid) {
        memoryDevice = {'properties': responseProperties};
        memory[key] = memoryDevice;
      }
    }
  }

  static setMemory(
      String key, String segment, dynamic property, dynamic value) {
    try {
      dynamic jsonKey = memory[key];
      dynamic jsonSegment = jsonKey[segment];
      dynamic jsonData = jsonSegment.data;
      bool updated = true;

      switch (segment) {
        case 'properties':
          switch (property) {
            case 'velocity':
              dynamic jsonProperties = jsonDecode(jsonData['properties']);
              if (jsonProperties == null) jsonProperties = {};
              jsonProperties['position'] = value.toString();
              jsonData['properties'] = jsonEncode(jsonProperties);
              break;
            case 'name':
              dynamic jsonProperties =
                  jsonDecode(jsonData['customer_properties']);
              if (jsonProperties == null) jsonProperties = {};
              jsonProperties['name'] = value.toString();
              jsonData['customer_properties'] = jsonEncode(jsonProperties);
              break;

            default:
              updated = false;
          }
          break;

        case 'config':
          switch (property) {
            case 'season':
              dynamic jsonResult = jsonDecode(jsonData['result']);
              if (jsonResult == null) jsonResult = {};
              jsonResult['season'] = value;
              jsonData['result'] = jsonEncode(jsonResult);
              break;

            // case 'time_slots_w':
            // case 'time_slots_h':
            case 'time_slots':
              dynamic jsonResult = jsonDecode(jsonData['result']);
              if (jsonResult == null) jsonResult = {};
              jsonResult[property] = jsonDecode(value);
              jsonData['result'] = jsonEncode(jsonResult);
              break;

            default:
              updated = false;
          }
          break;

        case 'zones':
          List zones = jsonDecode(jsonData['result']);
          if (zones == null)
            zones = [
              {"id": property}
            ];

          Map zone = zones.firstWhere((e) => e['id'] == property);
          (value as Map).entries.forEach((e) {
            if (e.key != 'id') {
              zone[e.key] = e.value;
            }
          });

          jsonData['result'] = jsonEncode(zones);
          break;

        default:
          updated = false;
      }

      if (updated) {
        SmeupLogService.writeDebugMessage(
            'updated memory \'$key-$segment-$property\' = $value',
            logType: LogType.info);
      } else {
        SmeupLogService.writeDebugMessage(
            'memory \'$key-$segment-$property\' = $value not implemented',
            logType: LogType.error);
      }
    } catch (e) {
      SmeupLogService.writeDebugMessage('Error in setMemory: $property, $value',
          logType: LogType.error);
    }

    //sleep(Duration(seconds: 1));
  }

  static Future<dynamic> copyMemory(String fromKey, String fromSegment,
      String toKey, String toSegment) async {
    dynamic jsonFromKey = memory[fromKey];
    Response jsonFromSegment = jsonFromKey[fromSegment];

    dynamic jsonToKey = memory[toKey] = Map();
    jsonToKey[toSegment] = Response(
        data: jsonDecode(jsonFromSegment.toString()),
        statusCode: jsonFromSegment.statusCode,
        requestOptions: null);

    SmeupLogService.writeDebugMessage(
        'copied memory from $fromKey-$fromSegment to $toKey-$toSegment',
        logType: LogType.info);
  }

  static removeMemoryKey(String key) {
    SmeupLogService.writeDebugMessage('removed the memory key $key',
        logType: LogType.info);
    memory.remove(key);
  }

  static clearMemory() {
    SmeupLogService.writeDebugMessage('clear memory', logType: LogType.info);
    memory = Map();
  }
}
