import 'package:ken/smeup/models/smeup_fun.dart';
import 'package:ken/smeup/services/transformers/smeup_data_transformer_interface.dart';

import '../smeup_data_service.dart';

class KokosTransformer implements SmeupDataTransformerInterface {
  @override
  transform(SmeupFun smeupFun, data) {
    switch (smeupFun.fun['fun']['component']) {
      case 'EXD':
        return data;

      case 'EXB':
        dynamic res = SmeupDataService.getEmptyDataStructure();

        // columns
        res['columns'] = data['columns'];

        // rows
        List rows = List<dynamic>.empty(growable: true);

        (data['rows'] as List).forEach((row) {
          var newRow = Map();
          (res['columns'] as List).forEach((column) {
            final value =
                row['fields'][column['code']]['smeupObject']['codice'];
            newRow[column['code']] = value;
            newRow['tipo'] =
                row['fields'][column['code']]['smeupObject']['tipo'];
            newRow['parametro'] =
                row['fields'][column['code']]['smeupObject']['parametro'];
            newRow['codice'] =
                row['fields'][column['code']]['smeupObject']['codice'];
            newRow['testo'] =
                row['fields'][column['code']]['smeupObject']['testo'];
          });
          rows.add(newRow);
        });

        res['rows'] = rows;
        res['type'] = 'SmeupDataTable';
        return res;

      case 'TRE':
        dynamic res = SmeupDataService.getEmptyDataStructure();
        List rows = List.empty(growable: true);
        for (var i = 0; i < (data['children'] as List).length; i++) {
          final child = (data['children'] as List)[i];
          final tipo = child['content']['tipo'];
          final parametro = child['content']['parametro'];
          final codice = child['content']['codice'];
          final testo = child['content']['testo'];

          var newRow = {
            'tipo': tipo,
            'parametro': parametro,
            'codice': codice,
            'value': testo,
            //'${child['content']['codice']}': testo
          };

          rows.add(newRow);
        }

        res['rows'] = rows;
        res['type'] = 'SmeupTreeNode';
        return res;

      default:
        return data;
    }
  }
}
