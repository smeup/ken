import 'package:ken/smeup/models/widgets/smeup_model.dart';

import 'smeup_dao.dart';

class SmeupListBoxDao extends SmeupDao {
  static Future<void> getData(SmeupModel model) async {
    await SmeupDao.getData(model);
  }
}
