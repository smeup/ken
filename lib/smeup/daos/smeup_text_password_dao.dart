import 'package:ken/smeup/models/widgets/smeup_text_password_model.dart';

import 'smeup_dao.dart';

class SmeupTextPasswordDao extends SmeupDao {
  static Future<void> getData(SmeupTextPasswordModel model) async {
    await SmeupDao.getData(model);
  }
}
