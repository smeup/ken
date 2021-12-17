import 'package:intl/intl.dart';
import 'package:ken/smeup/models/widgets/smeup_model.dart';
import 'package:ken/smeup/services/smeup_data_service.dart';

class SmeupWidgetMixin {
  runControllerActivities(SmeupModel model) {
    // print('setUIProperties in mixin');
  }

  /// this function will format each field in the "data.rows"
  /// by checking the corresponing "data.columns"
  dynamic formatDataFields(SmeupModel model) {
    if (!SmeupDataService.isDataStructure(model.data)) return null;

    dynamic res = SmeupDataService.getEmptyDataStructure();
    res['messages'] = model.data['messages'];
    res['columns'] = model.data['columns'];
    res['rows'] = model.data['rows'];
    res['type'] = model.data['type'];

    if (res['rows'] != null &&
        (res['rows'] as List).length > 0 &&
        res['columns'] != null &&
        (res['columns'] as List).length > 0) {
      for (var z = 0; z < (res['rows'] as List).length; z++) {
        var row = res['rows'][z];

        for (var i = 0; i < (res['columns'] as List).length; i++) {
          var col = res['columns'][i];

          if (col['ogg'] != null) {
            var cell = row[col['code']];
            if (cell != null) {
              final ogg = col['ogg'].toString();
              switch (ogg) {
                case 'D8*YYMD':
                  var dateToConvert = DateTime.tryParse(cell);
                  if (dateToConvert != null)
                    cell = DateFormat("dd/MM/yyyy").format(dateToConvert);
                  break;
                default:
              }
            }
            row[col['code']] = cell;
          }
        }
      }
    }

    return res;
  }
}
