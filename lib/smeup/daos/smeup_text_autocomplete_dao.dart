import 'package:mobile_components_library/smeup/models/widgets/smeup_text_autocomplete_model.dart';

import 'smeup_dao.dart';

class SmeupTextAutocompleteDao extends SmeupDao {
  static Future<void> getData(SmeupTextAutocompleteModel model) async {
    await SmeupDao.getData(model);
  }
}
