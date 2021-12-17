import 'package:mobile_components_library/smeup/models/widgets/smeup_combo_model.dart';

import 'smeup_dao.dart';

class SmeupComboDao extends SmeupDao {
  static Future<void> getData(SmeupComboModel model) async {
    await SmeupDao.getData(model);
  }
}
